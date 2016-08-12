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
end
