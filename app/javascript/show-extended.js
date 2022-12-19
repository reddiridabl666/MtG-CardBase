for (let btn of document.getElementsByClassName('dropdown-btn')) {
    let card_id = btn.id.substring(btn.id.indexOf('-'));

    // let base_id = 'base' + card_id;
    let extended_id = 'extended' + card_id;

    btn.addEventListener('click', () => {
        // let base = document.getElementById(base_id)
        let extended = document.getElementById(extended_id)

        if (extended.style.display === 'none') {
            extended.style.display = 'block';
        } else {
            extended.style.display = 'none';
        }
    });
}
