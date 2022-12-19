class AddUuidToCardInstance < ActiveRecord::Migration[7.0]
  def change
    add_column :card_instances, :uuid, :string
    add_index :card_instances, :uuid, unique: true
  end
end
