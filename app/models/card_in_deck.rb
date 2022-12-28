# frozen_string_literal: true

# deck card model
class CardInDeck < ApplicationRecord
  belongs_to :deck
  belongs_to :card_instance

  def total
    CardInDeck.where(deck:).joins(:card_instance).where(card_instance: { card: card_instance.card }).sum(:num)
  end

  def self.total_same(deck, card)
    CardInDeck.where(deck:).joins(:card_instance).where(card_instance: { card: }).sum(:num)
  end

  def self.remove(card)
    if (card.num - 1).zero?
      Deck.remove_colors(card.deck, card)
      card.destroy
    else
      card.num -= 1
      card.save
    end
  end
end
