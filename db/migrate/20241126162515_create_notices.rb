class CreateNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :notices do |t|
      t.integer :admin_id, null: false, foreign_key: true
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
