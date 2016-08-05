class Book < ApplicationRecord
  belongs_to :category

  has_many :userbooks, dependent: :destroy
  has_many :reviews
end
