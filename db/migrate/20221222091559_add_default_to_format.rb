class AddDefaultToFormat < ActiveRecord::Migration[7.0]
  def change
    change_column :formats, :max_same, :integer, default: 4
    change_column :formats, :min_cards, :integer, default: 60
    add_column :formats, :max_cards, :integer, default: nil
  end
end
