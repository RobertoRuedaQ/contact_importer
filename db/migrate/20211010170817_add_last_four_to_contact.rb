class AddLastFourToContact < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :last_four, :string, null: false
  end
end
