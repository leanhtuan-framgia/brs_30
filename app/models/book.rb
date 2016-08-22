class Book < ApplicationRecord
  belongs_to :category

  has_many :user_books, dependent: :destroy
  has_many :reviews

  validates :title, presence: true, length: {maximum: 100}
  validates :author, presence: true
  validates :picture, presence: true
  validates :category, presence: true
  validates :publish_date, presence: true
  validates :number_of_page, presence: true, numericality: true

  scope :search_category, ->category_id {where category_id: category_id}
  scope :filter_books, ->filter_name {order "#{filter_name}": :desc}
  scope :search_publish_date, ->search_name {where "title LIKE '%#{search_name}%'
    OR publish_date LIKE ? ", search_name.to_date}
  scope :search_string, ->search_name {where "title LIKE '%#{search_name}%'
    OR author LIKE '%#{search_name}%' OR number_of_page LIKE '#{search_name}'"}

  class << self
    def search_books search_name
      begin
        search_publish_date search_name
      rescue Exception => e
        search_string search_name
      end
    end
  end
end
