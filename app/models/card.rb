class Card < ApplicationRecord
  has_many :card_instances

  MTG_SYMBOL = /\{((1?\d|20)|[2RG]?W|[2WG]?U|[2UW]?B|[2UB]?R|[2RB]?G|C|X|[CWUBRG]P)}/.freeze

  validates :manacost, format: {
    with: /\A(#{MTG_SYMBOL})+\z/
  }

  def legendarity
    'Legendary ' if legendary
  end
end
