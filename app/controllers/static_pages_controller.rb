class StaticPagesController < ApplicationController
  def home
    @feed_items = if logged_in?
      current_user.feeds.order(created_at: :desc).paginate page: params[:page],
        per_page: Settings.size
    else
      Activity.all.order(created_at: :desc).paginate page: params[:page],
        per_page: Settings.size
    end
  end
end
