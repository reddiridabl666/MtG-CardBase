class AddManaValueIntegerToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :mana_value, :integer
  end
end
