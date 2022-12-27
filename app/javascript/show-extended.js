function dropdown_buttons() {
    return document.getElementsByClassName('dropdown-btn');
}

for (let btn of dropdown_buttons()) {
    let card = cardByBtn(btn);

    btn.addEventListener('click', () => {
        if (isHidden(card)) {
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

function isHidden(obj) {
    return obj.classList.contains('d-none')
}

function hideCard(card, btn) {
    btn.classList.remove('rotated');
    hide(card)
}

function show(obj) {
    obj.classList.remove('d-none');
}

function hide(obj) {
    obj.classList.add('d-none');
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
    if (isHidden(filter_form)) {
        filter_form.classList.remove('d-none')
    } else {
        filter_form.classList.add('d-none')
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
