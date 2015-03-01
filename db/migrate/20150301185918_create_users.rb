class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email_address
      t.belongs_to :organization, index: true

      t.timestamps null: false
    end
    add_foreign_key :users, :organizations
    add_index :users, :email_address, unique: true
  end
end
