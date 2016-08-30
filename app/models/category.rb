class Category < ApplicationRecord
  has_many :books, dependent: :destroy, inverse_of: :category
  accepts_nested_attributes_for :books, allow_destroy: true
end
