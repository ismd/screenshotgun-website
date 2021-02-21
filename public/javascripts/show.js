window.onload = () => {
    document.querySelectorAll('.js-toggle-popup').forEach((selector) => {
        selector.addEventListener('click', () => {
            document.querySelector('.js-main-content').classList.toggle('hidden');
            document.querySelector('.js-popup').classList.toggle('hidden');
        });
    });
};
