class Expansion < ApplicationRecord
  has_many :card_instances

  validates :name, :code, :release_date, :card_num, presence: true
  validates :card_num, numericality: { only_integer: true, greater_than: 0 }

  def symbol(rarity, size=1)
    "ss ss-#{code.downcase} ss-#{rarity}#{size == 1 ? "" : " ss-#{size}x"}"
  end
end
