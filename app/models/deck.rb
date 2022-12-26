class Deck < ApplicationRecord
  belongs_to :format
  belongs_to :user

  has_many :cards, class_name: 'CardInDeck', dependent: :delete_all

  validates :name, uniqueness: {
    scope: :user,
    message: 'You already have a deck with such name'
  }

  private

  def validate_card_instance_num
    if cards.any? { |card| card.card_instance.card.supertypes.exclude?('Basic') && card.total > format.max_same }
      errors.add(:cards, "Can't have more then #{format.max_same} same cards")
    end
  end
end
