CREATE TABLE IF NOT EXISTS sections (
 id INT AUTO_INCREMENT PRIMARY KEY,
 title VARCHAR(100) NOT NULL,
 content TEXT NOT NULL
);

INSERT INTO sections (title, content)
VALUES  ('Test Tekstu', '<p>Możesz edytować ten tekst, zmieniać style CSS lub dodawać nowe elementy HTML, aby testować kontenery i bind mounty.</p><button class="btn-test">Kliknij mnie</button>'),
        ('Lista Testów', '<ul><li>Zmiana plików HTML/CSS w kontenerze</li><li>Podgląd efektów w przeglądarce</li><li>Testowanie nowych elementów</li></ul>'),
        ('Obraz Testowy', '<img src="https://picsum.photos/820/600" alt="Testowy obraz">');
