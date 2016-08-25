module ActivitiesHelper
  def activity activity
    if activity.act_type == "follow" || activity.act_type == "unfollow"
      User.find_by id: activity.target_id
    elsif activity.act_type == "comment"
      Review.find_by id: activity.target_id
    else
      Book.find_by id: activity.target_id
    end
  end

  def target_name activity
    if activity.act_type == "follow" || activity.act_type == "unfollow"
      activity(activity).name
    else
      activity(activity).title
    end
  end
end
