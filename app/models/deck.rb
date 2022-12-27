class Deck < ApplicationRecord
  belongs_to :format
  belongs_to :user

  has_many :cards, class_name: 'CardInDeck', dependent: :delete_all

  validates :name, uniqueness: {
    scope: :user,
    message: 'You already have a deck with such name'
  }

  def colors
    @colors = ''
    vars = %w[W U B R G]
    cards.each do |card|
      card_mc = card.card_instance.card.manacost
      puts card_mc
      next if card_mc.blank?
      card_mc.chars.each { |char| @colors += "{#{char}}" if vars.include?(char) && @colors.exclude?(char) }
    end
    @colors = '{C}' if @colors.blank?
    @colors
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
