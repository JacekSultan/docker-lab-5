document.addEventListener('DOMContentLoaded', () => {
    document.getElementById('current-year').textContent = new Date().getFullYear();

    document.addEventListener('click', e => {
        if (e.target.classList.contains('btn-test') || e.target.closest('.btn-test')) {
            alert('Przycisk działa!')
        }
    })

    fetch('http://localhost:5555/api/sections/').then(res => res.json()).then(data => {
        Object.keys(data).forEach(key => {
            document.querySelector('main').innerHTML += `<section class="card"><h2>${data[key].title}</h2>${data[key].content}</section>`;
        })
    }).catch(err => console.error('Błąd fetch:', err));
})