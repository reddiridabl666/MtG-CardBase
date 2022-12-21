class Card < ApplicationRecord
  has_many :card_instances

  MANA_SYMBOL = /\{((1?\d|20)|(2|[RG]\/)?W|(2|[WG]\/)?U|(2|[UW]\/)?B|(2|[UB]\/)?R|(2|[RB]\/)?G|C|X|[CWUBRG]\/P)}/.freeze
  MTG_SYMBOL = /(#{MANA_SYMBOL}|{[TQE]})/.freeze

  default_scope { order(name: :asc) }

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

  def self.filter_by_mana(cards, ge, le)
    cards = cards.where("mana_value >= ?", ge) if ge.present?
    cards = cards.where("mana_value <= ?", le) if le.present?

    cards
  end

  def self.filter_by_power(cards, ge, le)
    cards = cards.where("power >= ?", ge).or(cards.where(power: %w[X *])) if ge.present?
    cards = cards.where("power <= ?", le).or(cards.where(power: %w[X *])) if le.present?

    cards
  end

  def self.filter_by_toughness(cards, ge, le)
    cards = cards.where("toughness >= ?", ge).or(cards.where(toughness: %w[X *])) if ge.present?
    cards = cards.where("toughness <= ?", le).or(cards.where(toughness: %w[X *])) if le.present?

    cards
  end

  def self.filter_by_types(cards, types, subtypes, supertypes)
    cards = cards.where(types: types.split) if types.present?
    cards = cards.where(subtypes: subtypes.split) if subtypes.present?
    cards = cards.where(supertypes: supertypes.split) if supertypes.present?

    cards
  end

  def self.filtered(params)
    cards = self.all

    cards = self.filter_by_mana(cards, params[:cost_ge], params[:cost_le])
    cards = self.filter_by_power(cards, params[:cost_ge], params[:cost_le])

    cards = self.filter_by_toughness(cards, params[:cost_ge], params[:cost_le])
    cards = self.filter_by_types(cards, params[:types], params[:subtypes], params[:supertypes])

    cards
  end
end
