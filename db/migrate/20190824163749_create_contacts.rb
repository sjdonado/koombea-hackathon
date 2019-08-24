class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :address, null: true
      t.string :phone, null: true

      t.belongs_to :user, index: true, null: true

      t.timestamps
    end

    add_index :contacts, :email, unique: true
  end
end
