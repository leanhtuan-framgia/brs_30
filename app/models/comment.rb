class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :content, presence: true
  include CreateActivity

  after_create :create_activity

  private
  def create_activity
    activity_build_create "comment", review_id, user_id
  end
end
