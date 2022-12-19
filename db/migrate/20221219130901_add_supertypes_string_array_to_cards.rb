class AddSupertypesStringArrayToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :supertypes, :string, array: true
  end
end
