class Deck < ApplicationRecord
  belongs_to :format
  belongs_to :user

  has_many :cards, class_name: 'CardInDeck', dependent: :delete_all

  validates :name, uniqueness: {
    scope: :user,
    message: 'You already have a deck with such name'
  }

  def add_card(card_instance)
    card_in_deck = cards.find_by(card_instance_id: card_instance.id)
    if card_in_deck.present?
      card_in_deck.num += 1
      card_in_deck.save
    else
      card = CardInDeck.create(deck_id: id, card_instance_id: card_instance.id)
      Deck.refresh_colors(self, card) if card.valid?
      save
    end
  end

  def self.refresh_colors(deck, card_in_deck)
    %w[W U B R G].each do |color|
      if card_in_deck.card_instance.card.manacost&.include?(color)
        deck.colors += "{#{color}}" if deck.colors.exclude?(color)
      end
    end

    deck.save
  end

  def self.remove_colors(deck, card_in_deck)
    %w[W U B R G].each do |color|
      if card_in_deck.card_instance.card.manacost&.include?(color)
        contains = false

        deck.cards.filter { |card| card != card_in_deck }.each do |card|
          contains = card.card_instance.card.manacost&.include? color
          break if contains
        end

        deck.colors.gsub!("{#{color}}", '') unless contains
      end
    end

    deck.save
  end

  def self.by_user(name)
    if name.blank?
      Deck.order(:user_id)
    else
      Deck.joins(:user).where("users.name = ?", name)
    end
  end

  def self.copy(deck, user=nil)
    copied = Deck.create(name: deck.name + ' copy', format_id: deck.format_id,
                         user_id: user.blank? ? deck.user_id : user.id)

    deck.cards.each do |card|
      CardInDeck.create(deck_id: copied.id, card_instance_id: card.card_instance_id, num: card.num)
    end

    copied
  end

  private

  def validate_card_instance_num
    if cards.any? { |card| card.card_instance.card.supertypes.exclude?('Basic') && card.total > format.max_same }
      errors.add(:cards, "Can't have more then #{format.max_same} same cards")
    end
  end
end
