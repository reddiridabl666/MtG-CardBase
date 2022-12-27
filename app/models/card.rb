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

  def self.all_types
    %w[Creature Enchantment Planeswalker Sorcery Instant Artifact Land]
  end

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

  def self.filter_by_name(cards, name)
    cards = cards.where("lower(name) like ?", '%' + Card.sanitize_sql_like(name.downcase) + '%') if name.present?
    cards
  end

  def self.filter_by_text(cards, text)
    cards = cards.where("lower(text) like ?", '%' + Card.sanitize_sql_like(text.downcase) + '%') if text.present?
    cards
  end

  def self.filter_by_flavour(cards, flavour)
    cards = cards.where("lower(flavour_text) like ?", '%' + Card.sanitize_sql_like(flavour.downcase) + '%') if flavour.present?
    cards
  end

  def self.filter_by_mana(cards, ge, le)
    cards = cards.where("mana_value >= ?", ge.to_i) if ge.present?
    cards = cards.where("mana_value <= ?", le.to_i) if le.present?

    cards
  end

  def self.filter_by_color(cards, params)
    colored = cards.where("(:w = '1' and manacost like '%W%') or (:u = '1' and manacost like '%U%') or
                           (:b = '1' and manacost like '%B%') or (:r = '1' and manacost like '%R%') or (:g = '1' and manacost like '%G%')",
                    w: params[:color_w], b: params[:color_b], u: params[:color_u], r: params[:color_r], g: params[:color_g])

    colorless = cards.where.not("? = '0' or (manacost like '%W%' or manacost like '%B%' or
                                 manacost like '%U%' or manacost like '%R%' or manacost like '%G%')", params[:color_c])

    lands = cards.where("? = 1 and manacost is null", params[:color_c])

    colored.or(colorless).or(lands)
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
    cards = self.filter_by_power(cards, params[:power_ge], params[:power_le])
    cards = self.filter_by_toughness(cards, params[:toughness_ge], params[:toughness_le])

    cards = self.filter_by_types(cards, params[:types], params[:subtypes], params[:supertypes])

    cards = self.filter_by_name(cards, params[:name])
    cards = self.filter_by_text(cards, params[:rules])
    cards = self.filter_by_flavour(cards, params[:flavour])

    cards = self.filter_by_color(cards, params)

    cards
  end
end
