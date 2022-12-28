require 'faker'

Format.create(name: 'Commander', max_same: 1, min_cards: 100, max_cards: 100)
Format.create(name: 'Standard')
Format.create(name: 'Modern')

100.times do
  User.create(name: Faker::Internet.unique.username[...20], password: Faker::Internet.password)
end

Rake::Task["mtg:add_set"].invoke('KLD')

User.all.each do |user|
  (0..4).to_a.sample.times do
    deck = Deck.create(name: 'Deck ' + Faker::Internet.unique.username, format_id: Format.all.sample.id, user: user)
    card_num = 60
    card_num = 100 if deck.format.name == 'Commander'

    while card_num > 0 do
      num = [(1..deck.format.max_same).to_a.sample, card_num].min
      card = CardInDeck.create(deck: deck, card_instance_id: CardInstance.all.sample.id, num: num)
      Deck.refresh_colors(deck, card) if card.valid?
      card_num -= num
    end

    deck.save
  end
end
