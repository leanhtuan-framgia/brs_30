class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  has_many :comments, dependent: :destroy

  include CreateActivity

  after_create :create_activiy

  private
  def create_activiy
    activity_build_create "Review", book_id, user_id
  end
end
