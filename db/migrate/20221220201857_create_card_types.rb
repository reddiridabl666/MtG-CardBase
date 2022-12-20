class CreateCardTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :card_types do |t|
      t.string :value
      t.integer :type

      t.timestamps
    end
    add_index :card_types, :value, unique: true
  end
end
