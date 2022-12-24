function dropdown_buttons() {
    return document.getElementsByClassName('dropdown-btn');
}

function card_buttons() {
    return document.getElementsByClassName('card-buttons');
}

function dropdown_button_containers() {
    return document.getElementsByClassName('dropdown-btn-container');
}

for (let btn of dropdown_buttons()) {
    let card = cardByBtn(btn);

    btn.addEventListener('click', () => {
        if (!card.classList.contains('shown')) {
            showCard(card, btn);
        } else {
            hideCard(card, btn);
        }
    });
}

function showCard(card, btn) {
    btn.classList.add('rotated');
    show(card);
}

function hideCard(card, btn) {
    btn.classList.remove('rotated');
    hide(card)
}

function show(obj) {
    obj.classList.add('shown');
}

function hide(obj) {
    obj.classList.remove('shown');
}

function cardByBtn(btn) {
    let card_id = btn.id.substring(btn.id.indexOf('-'));
    let extended_id = 'extended' + card_id;
    return document.getElementById(extended_id)
}

document.getElementById('collapse-btn').addEventListener('click', () => {
    for (let btn of dropdown_buttons())  {
        hideCard(cardByBtn(btn), btn);
    }
});

document.getElementById('expand-btn').addEventListener('click', () => {
    for (let btn of dropdown_buttons())  {
        showCard(cardByBtn(btn), btn);
    }
});

document.getElementById('filter-btn').addEventListener('click', () => {
    const filter_form = document.getElementById('filter-form');
    if (!filter_form.classList.contains('shown')) {
        show(filter_form);
    } else {
        hide(filter_form);
    }
});

document.getElementById('new-deck-btn').addEventListener('click', (event) => {
    event.target.classList.add('d-none');
});

// document.getElementById('create-deck-btn').addEventListener('click', () => {
//     for (let obj of dropdown_button_containers()) {
//         obj.style.display = 'none';
//     }
//
//     for (let obj of card_buttons()) {
//         obj.style.display = 'flex';
//     }
// });
