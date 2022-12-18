class CardInstance < ApplicationRecord
  belongs_to :expansion
  belongs_to :card
  has_one_attached :image

  enum rarity: { common: 0, uncommon: 1, rare: 2, mythic: 3 }

  def type
    "#{card.type}#{card.subtype.present? ? "- #{card.subtype}" : ''}"
  end

  def expansion_symbol(size=1)
    expansion.symbol(rarity, size)
  end

  def expansion_symbol_common(size=1)
    expansion.symbol('common', size)
  end
end
