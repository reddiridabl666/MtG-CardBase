class RenameTypeInCardTypeToTypeScope < ActiveRecord::Migration[7.0]
  def change
    rename_column :card_types, :type, :type_scope
  end
end
