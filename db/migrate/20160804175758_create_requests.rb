class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :name
      t.string :author
      t.date :publish_date
      t.string :description
      t.integer :req_status, default: 0
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
