class CreateCardInstances < ActiveRecord::Migration[7.0]
  def change
    create_table :card_instances do |t|
      t.string :flavour_text
      t.references :expansion, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true
      t.integer :rarity

      t.timestamps
    end
  end
end
