class RenameCardSubTypeToSubtypes < ActiveRecord::Migration[7.0]
  def change
    rename_column :cards, :subtype, :subtypes
    change_column :cards, :subtypes, "varchar[] USING (string_to_array(subtypes, ' '))"
  end
end
