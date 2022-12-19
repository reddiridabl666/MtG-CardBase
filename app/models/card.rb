class Card < ApplicationRecord
  has_many :card_instances

  MANA_SYMBOL = /\{((1?\d|20)|[2RG]?W|[2WG]?U|[2UW]?B|[2UB]?R|[2RB]?G|C|X|[CWUBRG]P)}/.freeze
  MTG_SYMBOL = /(#{MANA_SYMBOL}|{[TQE]})/.freeze

  validates :name, uniqueness: true
  validates :name, :power, :toughness, :text, :types, :subtypes, :mana_value, :manacost, presence: true

  validates :manacost, format: {
    with: /\A(#{MANA_SYMBOL})+\z/
  }

  validates :power, :toughness, numericality: {
    only_integer: true, greater_than_or_equal_to: 0
  }

  def type
    "#{types.join}#{subtypes.present? ? " - #{subtypes.join}" : ''}"
  end

  def has_stats
    power.present? && toughness.present?
  end

  def stats
    return '-' unless has_stats

    "#{power} / #{toughness}"
  end
end
