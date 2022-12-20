class MakeValueToArray < ActiveRecord::Migration[7.0]
  def change
    change_column :card_types, :value, "varchar[] USING (string_to_array(value, ''))"
  end
end
