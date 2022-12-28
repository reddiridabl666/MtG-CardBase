class AddColorsToDeck < ActiveRecord::Migration[7.0]
  def change
    add_column :decks, :colors, :string, default: ''
  end
end
