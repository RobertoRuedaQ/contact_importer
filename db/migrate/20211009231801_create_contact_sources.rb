class CreateContactSources < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_sources do |t|
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
