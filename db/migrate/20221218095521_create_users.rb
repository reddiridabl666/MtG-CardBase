class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, limit: 20
      t.string :password_digest
      t.boolean :is_admin

      t.timestamps
    end
    add_index :users, :name, unique: true
  end
end
