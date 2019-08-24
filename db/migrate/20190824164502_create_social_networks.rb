class CreateSocialNetworks < ActiveRecord::Migration[5.2]
  def change
    create_table :social_networks do |t|
      t.integer :kind
      t.string :url
      t.string :number

      t.belongs_to :contact, index: true, null: true

      t.timestamps
    end
  end
end
