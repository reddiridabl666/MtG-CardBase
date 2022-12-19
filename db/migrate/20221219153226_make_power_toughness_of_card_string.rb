class MakePowerToughnessOfCardString < ActiveRecord::Migration[7.0]
  def change
    change_column :cards, :power, :string, limit: 2
    change_column :cards, :toughness, :string, limit: 2
  end
end
