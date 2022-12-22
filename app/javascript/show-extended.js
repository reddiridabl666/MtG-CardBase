function dropdown_buttons() {
    return document.getElementsByClassName('dropdown-btn');
}

for (let btn of dropdown_buttons()) {
    let card = cardByBtn(btn);

    btn.addEventListener('click', () => {
        if (!card.classList.contains('active')) {
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
    obj.classList.add('active');
}

function hide(obj) {
    obj.classList.remove('active');
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
    if (!filter_form.classList.contains('active')) {
        show(filter_form);
    } else {
        hide(filter_form);
    }
});

document.getElementById('new-deck-btn').addEventListener('click', (event) => {
    event.target.style.display = 'none';
});
