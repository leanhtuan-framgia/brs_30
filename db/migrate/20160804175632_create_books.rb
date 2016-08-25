class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :picture
      t.date :publish_date
      t.string :author
      t.integer :number_of_page
      t.integer :avg_rate, default: 0
      t.integer :quantity_favorite, default: 0
      t.references :category, index: true, foreign_key: true

      t.timestamps
    end
  end
end
