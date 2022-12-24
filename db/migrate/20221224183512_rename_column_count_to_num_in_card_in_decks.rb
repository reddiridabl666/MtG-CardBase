class RenameColumnCountToNumInCardInDecks < ActiveRecord::Migration[7.0]
  def change
    rename_column :card_in_decks, :count, :num
  end
end
