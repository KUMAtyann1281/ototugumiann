class CreateUserGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :user_groups do |t|
      t.integer :user_id,  null: false, foreign_key: true
      t.integer :group_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
