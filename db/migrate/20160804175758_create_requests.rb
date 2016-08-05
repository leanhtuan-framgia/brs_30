class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :request_book_name
      t.string :author
      t.date :publish_date
      t.string :description
      t.string :req_status
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
