class Card < ApplicationRecord
  has_many :card_instances

  MANA_SYMBOL = /\{((1?\d|20)|(2|[RG]\/)?W|(2|[WG]\/)?U|(2|[UW]\/)?B|(2|[UB]\/)?R|(2|[RB]\/)?G|C|X|[CWUBRG]P)}/.freeze
  MTG_SYMBOL = /(#{MANA_SYMBOL}|{[TQE]})/.freeze

  validates :name, uniqueness: true
  validates :name, :types, :mana_value, presence: true

  validates :manacost, format: {
    with: /\A(#{MANA_SYMBOL})+\z/,
    allow_nil: true,
    message: 'Manacost should have valid format'
  }

  validates :power, :toughness, format: {
    with: /(\d{1,2}|X|\*)/,
    allow_nil: true,
    message: 'Stats can only be a 1-2 decimal number, X, or *'
  }

  def type
    "#{supertypes.present? ? "#{supertypes.join(' ')} " : ''}#{types.join(' ')}#{subtypes.present? ? " - #{subtypes.join(' ')}" : ''}"
  end

  def has_stats
    power.present? && toughness.present?
  end

  def stats
    return '-' unless has_stats

    "#{power} / #{toughness}"
  end
end
