class DefaultLegendarityFalse < ActiveRecord::Migration[7.0]
  def change
    change_column_default  :cards, :legendary, false
  end
end
