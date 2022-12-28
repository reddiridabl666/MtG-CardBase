# frozen_string_literal: true

# card type model
class CardType < ApplicationRecord
  validates :value, uniqueness: true
  enum type_scope: %i[normal sub super]

  default_scope { order(value: :asc) }

  def to_s
    value.join ' '
  end
end
