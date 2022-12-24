class AddDefault1RoCardsInDeck < ActiveRecord::Migration[7.0]
  def change
    change_column :card_in_decks, :count, :integer, default: 1
  end
end
