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
    card.classList.add('active');
}
function hideCard(card, btn) {
    btn.classList.remove('rotated');
    card.classList.remove('active');
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

