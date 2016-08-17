module CreateActivity
  def activity_build_create act_type, target_id, user_id
    Activity.create act_type: act_type, target_id: target_id,
      user_id: user_id
  end
end
