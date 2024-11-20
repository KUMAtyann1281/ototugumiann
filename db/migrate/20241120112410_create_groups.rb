class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :image_id
      t.integer :owner_id
      t.string :name
      t.text :information

      t.timestamps
    end
  end
end
