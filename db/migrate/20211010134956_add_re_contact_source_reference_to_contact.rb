class AddReContactSourceReferenceToContact < ActiveRecord::Migration[5.2]
  def change
    add_reference :contacts, :contact_source, foreign_key: true
  end
end
