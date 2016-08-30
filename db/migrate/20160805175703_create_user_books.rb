class CreateUserBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :user_books do |t|
      t.boolean :favorite, default: false
      t.integer :read_status, default: 0
      t.integer :rate
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true

      t.timestamps
    end
  end
end
