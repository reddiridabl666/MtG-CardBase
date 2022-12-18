class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.integer :power
      t.integer :toughness
      t.text :text
      t.string :subtype
      t.boolean :legendary
      t.string :manacost

      t.timestamps
    end
    add_index :cards, :name, unique: true
  end
end
