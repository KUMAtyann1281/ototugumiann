class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.integer :post_id, null: false, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
