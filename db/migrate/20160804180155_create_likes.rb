class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :activity_id

      t.timestamps
    end
    add_index :likes, :user_id
    add_index :likes, :activity_id
    add_index :likes, [:user_id, :activity_id], unique:true
  end
end
