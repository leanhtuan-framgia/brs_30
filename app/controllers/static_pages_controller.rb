class StaticPagesController < ApplicationController
  def home
    @feed_items = if logged_in?
      current_user.feeds.order(created_at: :desc).paginate page: params[:page],
        per_page: Settings.size
    else
      Activity.all.order(created_at: :desc).paginate page: params[:page],
        per_page: Settings.size
    end
    @books = Book.order("updated_at").limit(Settings.limit_book)
    @reviews = Review.order("updated_at").limit(Settings.limit_review)
  end
end
