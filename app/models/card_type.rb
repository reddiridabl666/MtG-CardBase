class CardType < ApplicationRecord
  validates :value, uniqueness: true
  enum type_scope: [:normal, :sub, :super]

  def to_s
    value.join ' '
  end
end
