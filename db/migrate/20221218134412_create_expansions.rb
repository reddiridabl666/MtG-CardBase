class CreateExpansions < ActiveRecord::Migration[7.0]
  def change
    create_table :expansions do |t|
      t.string :name
      t.string :code
      t.integer :card_num
      t.date :release_date

      t.timestamps
    end
    add_index :expansions, :name, unique: true
    add_index :expansions, :code, unique: true
  end
end
