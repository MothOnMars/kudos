class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :email_address, null: false
      t.belongs_to :organization, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :users, :organizations
    add_index :users, :email_address, unique: true
  end
end
