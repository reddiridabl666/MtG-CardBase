require 'rails_helper'

RSpec.describe Deck, type: :model do
  it 'is copied correctly' do
    deck = Deck.create(name: 'test', user: User.all.sample, format: Format.all.sample)
    (5..10).to_a.sample.times do
      CardInDeck.create(deck: deck, card_instance: CardInstance.all.sample, num: (1..4).to_a.sample)
    end

    clone = Deck.copy(deck)

    expect(clone.name).to eq deck.name + ' copy'

    original = deck.cards.order(:card_instance_id)
    clone.cards.order(:card_instance_id).each_with_index do |cloned, id|
      expect(cloned.card_instance_id).to eq original[id].card_instance_id
      expect(cloned.num).to eq original[id].num
    end

    expect(clone.user_id).to eq deck.user_id
    expect(clone.format_id).to eq deck.format_id
  end

  it 'can add cards to itself' do
    deck = Deck.create(name: 'test', user: User.all.sample, format: Format.all.sample)
    card_instance = CardInstance.all.sample

    prev = CardInDeck.count

    deck.add_card(card_instance)

    expect(deck.cards.count).to eq 1
    expect(deck.cards.first.num).to eq 1

    expect(CardInDeck.count).to eq prev + 1

    deck.add_card(card_instance)
    expect(deck.cards.first.num).to eq 2
    expect(CardInDeck.count).to eq prev + 1
  end
end
