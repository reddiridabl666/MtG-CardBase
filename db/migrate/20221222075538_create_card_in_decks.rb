class CreateCardInDecks < ActiveRecord::Migration[7.0]
  def change
    create_table :card_in_decks do |t|
      t.references :deck, null: false, foreign_key: true
      t.references :card_instance, null: false, foreign_key: true
      t.integer :count

      t.timestamps
    end
  end
end
