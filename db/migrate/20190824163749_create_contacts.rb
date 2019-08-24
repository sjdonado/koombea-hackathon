class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :address, null: true
      t.string :phone, null: true
      t.integer :owner_id
      t.integer :user_id, null: true

      # add_reference(:users, :owner, foreign_key: { to_table: :contacts })
      # add_reference(:users, :user, foreign_key: { to_table: :contacts })
      # add_reference :users, :owner, foreign_key: true
      # add_reference :users, :user, foreign_key: true

      t.timestamps
    end

    add_index :contacts, :email, unique: true
    add_index :contacts, :owner_id
    add_index :contacts, :user_id
  end
end
