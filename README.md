# Docker – Python + MariaDB + HTML (multikontenerowe środowisko)

Repozytorium demonstracyjne do zajęć:

**Docker i konteneryzacja - od podstaw do środowisk produkcyjnych**

Celem projektu jest pokazanie, jak uruchomić trzy kontenery w jednej sieci Docker: frontend (web/Nginx), backend (api/Flask) oraz bazę danych (MariaDB) z automatycznym importem dumpa przy pierwszym starcie, a także jak konfigurować środowiska developerskie i produkcyjne przy użyciu wielu plików docker-compose.

---

## Co znajduje się w repozytorium

```text
.
├── web/
│   ├── Dockerfile
│   └── app/
│       ├── favicon.ico
│       ├── index.html
│       ├── script.js
│       └── style.css
├── api/
│   ├── app.py               # backend Python/Flask
│   ├── Dockerfile
│   └── requirements.txt     # zależności backendu
├── db/
│   └── init.sql             # dump startowy do MariaDB
├── .env.example
├── docker-compose.yml
├── docker-compose.override.yml
├── docker-compose.override.dev.yml
└── README.md
```
- `web/app/index.html` - prosty frontend HTML/JS, pobiera dane z API
- `api/app.py` - backend Python/Flask
- `db/init.sql` - dump startowy do MariaDB (tabela sections)
- `.env.example` - przykładowy plik zmiennych środowiskowych
- `docker-compose*.yml` - konfiguracja środowisk Compose

## Czego uczy ten przykład
- pracy z Docker Compose w realnym, wielokontenerowym projekcie
- komunikacji frontend ↔ backend ↔ baza danych
- użycia zmiennych środowiskowych (`.env`)
- automatycznego importu dumpa SQL przy pierwszym starcie bazy
- korzystania z plików `docker-compose.override.yml`
- debugowania aplikacji przez logi i testy połączeń

## Architektura aplikacji
- web - Nginx serwujący statyczną stronę HTML
- api - Flask API udostępniające endpoint `/api/sections/`
- db - MariaDB z automatycznym importem dumpa przy pierwszym uruchomieniu

Wszystkie kontenery działają w jednej sieci Docker i komunikują się po nazwach usług.

## Przygotowanie projektu (ważne)
Projekt korzysta z pliku `.env` do konfiguracji zmiennych środowiskowych.

1️⃣ Skopiuj plik `.env`

Przed pierwszym uruchomieniem koniecznie wykonaj:
```shell
cp .env.example .env
```

Następnie możesz (opcjonalnie) dostosować wartości w pliku `.env`, np. hasło do bazy lub porty.

## Jak uruchomić
### 2️⃣ Uruchom środowisko
```shell
  docker compose up --build
```
- frontend: http://localhost:8080
- backend API: http://localhost:5000/api/sections/
- baza danych: MariaDB w kontenerze `db`
### 3️⃣ Zatrzymanie środowiska
```shell
  docker compose down
```
Aby usunąć również dane bazy i wymusić ponowny import dumpa:
```shell
  docker compose down -v
```

### 4️⃣ Uruchomienie w trybie developerskim (override)
Projekt zawiera dodatkowy plik: `docker-compose.override.dev.yml`, który montuje lokalne pliki frontendowe do kontenera `web`:
```yaml
services:
  web:
    volumes:
      - ./web/app:/usr/share/nginx/html
```
Dzięki temu możliwa jest praca bez przebudowy obrazu.
### Aby uruchomić środowisko z wykorzystaniem override dev:
```shell
  docker compose \
    -f docker-compose.yml \
    -f docker-compose.override.yml \
    -f docker-compose.override.dev.yml \
    up --build
```
### Co daje tryb developerski
- natychmiastowy podgląd zmian w plikach HTML
- brak konieczności wykonywania `docker compose build`
- szybsza praca i łatwiejsze testowanie
- realistyczny workflow znany z projektów zespołowych

Edytujesz pliki lokalnie → zapisujesz → odświeżasz przeglądarkę → widzisz zmiany
## Uwagi
- Dump SQL jest wykonywany tylko na czystej bazie danych
- Pliki `docker-compose.override*.yml` pozwalają łatwo modyfikować konfigurację dla różnych środowisk
- Projekt odzwierciedla uproszczoną architekturę realnych aplikacji produkcyjnych
- Kod aplikacji jest celowo prosty - celem ćwiczenia jest zrozumienie Dockera i Compose, a nie złożona logika biznesowa