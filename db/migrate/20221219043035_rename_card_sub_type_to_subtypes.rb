class RenameCardSubTypeToSubtypes < ActiveRecord::Migration[7.0]
  def change
    rename_column :cards, :subtype, :subtypes
    change_column :cards, :subtypes, :string, array: true
  end
end
