class CreateRecordLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :record_logs do |t|
      t.references :contact_source, foreign_key: true
      t.string :comments

      t.timestamps
    end
  end
end
