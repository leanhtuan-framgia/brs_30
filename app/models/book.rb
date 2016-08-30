class Book < ApplicationRecord
  belongs_to :category

  has_many :user_books, dependent: :destroy
  has_many :reviews

  scope :get_book_favorite,
    -> user_id{where("id IN (SELECT book_id FROM user_books WHERE
    user_id = ? AND favorite = ?)", user_id, true)}

  validates :title, presence: true, length: {maximum: 100}
  validates :author, presence: true
  validates :picture, presence: true
  validates :category, presence: true
  validates :publish_date, presence: true
  validates :number_of_page, presence: true, numericality: true

  scope :search_category, ->category_id {where category_id: category_id}
  scope :sort_books, ->sort_name {order "#{sort_name}": :desc}
  scope :search_publish_date, ->search_name {where "publish_date LIKE ? ",
    search_name.to_date}
  scope :search_title, ->search_name {where "title LIKE '%#{search_name}%'"}
  scope :search_author, ->search_name {where "author LIKE '%#{search_name}%'"}
  scope :search_number_of_page, ->number_of_page {where "number_of_page between
    0 and #{number_of_page}"}

  enum book_attribute: [:author, :number_of_page, :publish_date]

  class << self
    def search_books search_name, type
      if type == "author"
        search_author search_name
      elsif type == "publish_date"
        search_publish_date search_name
      elsif type == "number_of_page"
        search_number_of_page search_name
      end
    end
  end
end
