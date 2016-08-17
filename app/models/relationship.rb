class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  include CreateActivity

  after_create :activity_create
  after_destroy :activity_destroy

  private
  def activity_create
    activity_build_create "Follow", followed_id, follower_id
  end

  def activity_destroy
    activity_build_create "Unfollow", followed_id, follower_id
  end
end
