/* Permet de compacter les listes d'observateurs et de communes */

document.addEventListener('DOMContentLoaded', function () {
    function setupToggle(btnId, targetId, showText = 'Afficher plus', hideText = 'Afficher moins') {
        const btn = document.getElementById(btnId);
        const target = document.getElementById(targetId);
        let expanded = false;
        if (btn && target) {
            btn.addEventListener('click', function () {
                expanded = !expanded;
                target.classList.toggle('d-none');
                btn.textContent = expanded ? hideText : showText;
            });
        }
    }
    setupToggle('toggle-observers-btn', 'more-observers');
    setupToggle('toggle-communes-btn', 'more-communes');
});