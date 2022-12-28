require 'rails_helper'

RSpec.describe CardInDeck, type: :model do
  it 'removes card from deck' do
    deck = Deck.create(name: 'test', user: User.all.sample, format: Format.all.sample)

    card_num = (5..10).to_a.sample
    card_num.times do
      CardInDeck.create(deck: deck, card_instance: CardInstance.all.sample, num: 2)
    end

    expect(deck.cards.size).to eq card_num

    CardInDeck.remove(deck.cards.first)
    expect(deck.cards.first.num).to eq 1

    CardInDeck.remove(deck.cards.first)
    CardInDeck.remove(deck.cards.first)

    expect(deck.cards.count).to eq card_num - 1
  end
end
