class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.datetime :date_of_birth, null: false
      t.string :telephone, null: false
      t.string :address, null: false
      t.string :credit_card, null: false
      t.string :franchise, null: false
      t.string :email, null: false
      t.references :user, null: false
      
      t.timestamps
    end
  end
end
