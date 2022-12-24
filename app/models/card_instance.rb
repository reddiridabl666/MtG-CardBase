class CardInstance < ApplicationRecord
  paginates_per 20

  belongs_to :expansion
  belongs_to :card
  has_one_attached :image

  enum rarity: { common: 0, uncommon: 1, rare: 2, mythic: 3 }
  validates :card_id, :expansion_id, :rarity, :uuid, presence: true
  validates :uuid, uniqueness: true

  # default_scope { order(card: :asc) }

  def expansion_symbol(size=1)
    expansion.symbol(rarity, size)
  end

  def self.rarity_from_string(str)
    case str
    when 'uncommon'
      1
    when 'rare'
      2
    when 'mythic'
      3
    else
      0
    end
  end

  def expansion_symbol_common(size=1)
    expansion.symbol('common', size)
  end

  def self.filter_by_expansion(cards, name)
    cards = cards.where(expansion_id: Expansion.find_by_name(name)) if name.present?

    cards
  end

  def self.filtered(params)
    cards = Card.filtered(params)
    instances = CardInstance.where(card_id: cards)

    self.filter_by_expansion(instances, params[:set])
  end
end
