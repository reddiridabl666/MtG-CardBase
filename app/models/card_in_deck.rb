class CardInDeck < ApplicationRecord
  belongs_to :deck
  belongs_to :card_instance

  def total
    CardInDeck.where(deck: deck).joins(:card_instance).where(card_instance: {card: card_instance.card}).sum(:count)
  end
end
