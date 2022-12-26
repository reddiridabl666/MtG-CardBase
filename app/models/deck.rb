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
    puts 'Colors:', @colors
    @colors
  end

  private

  def validate_card_instance_num
    if cards.any? { |card| card.card_instance.card.supertypes.exclude?('Basic') && card.total > format.max_same }
      errors.add(:cards, "Can't have more then #{format.max_same} same cards")
    end
  end
end
