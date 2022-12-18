class CardInstance < ApplicationRecord
  belongs_to :expansion
  belongs_to :card
  has_one_attached :image

  enum rarity: { common: 0, uncommon: 1, rare: 2, mythic: 3 }
end
