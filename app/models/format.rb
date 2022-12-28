# frozen_string_literal: true

class Format < ApplicationRecord
  has_many :decks
  validates :name, uniqueness: true
end
