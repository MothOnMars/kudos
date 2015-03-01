class CreateKudos < ActiveRecord::Migration
  def change
    create_table :kudos do |t|
      t.string :message, null: false
      t.belongs_to :sender, index: true, null: false
      t.belongs_to :recipient, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :kudos, :users, column: :sender_id
    add_foreign_key :kudos, :users, column: :recipient_id
  end
end
