require 'rails_helper'

RSpec.describe Card, type: :model do
  it 'validates mana cost' do
    card = Card.new(name: 'test', mana_value: 0, types: ['Land'], power: 'X', toughness: '*')

    card.manacost = '{1}{2}{G}{U}{G/U}{B/R}{2W}{B/P}{W/P}'

    expect(card.valid?).to be true
    card.manacost += ' '
    expect(card.valid?).to be false

    card.manacost.chomp!(' ')
    expect(card.valid?).to be true

    card.manacost += '{T}'
    expect(card.valid?).to be false
  end

  it 'validates power and toughness' do
    card = Card.new(name: 'test', mana_value: 0, types: ['Land'], power: 'X', toughness: '*')
    expect(card.valid?).to be true

    card.power = '1'
    card.toughness = '99'
    expect(card.valid?).to be true

    card.power = '123'
    expect(card.valid?).to be false

    card.power = '-1'
    expect(card.valid?).to be false

    card.power = nil
    expect(card.valid?).to be true
  end
end
