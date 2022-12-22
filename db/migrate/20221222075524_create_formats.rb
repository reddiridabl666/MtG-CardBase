class CreateFormats < ActiveRecord::Migration[7.0]
  def change
    create_table :formats do |t|
      t.string :name
      t.integer :min_cards
      t.integer :max_same

      t.timestamps
    end
    add_index :formats, :name, unique: true
  end
end
