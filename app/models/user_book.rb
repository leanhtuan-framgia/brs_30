class UserBook < ApplicationRecord
  belongs_to :book
  belongs_to :user

  enum read_status: [:unread, :reading, :read]
  include CreateActivity

  after_create :activity_create
  after_update :activity_create

  scope :get_reading_history,
    -> user_id{where("user_id = ? AND (read_status = ? OR read_status = ?)",
    user_id, read_statuses[:reading], read_statuses[:reading])}

  private
  def activity_create
    if read_status_changed?
      activity_build_create read_status, book_id, user_id
    elsif favorite_changed?
      if favorite
        activity_build_create "favorite", book_id, user_id
        self.book.quantity_favorite += 1
      else
        activity_build_create "unfavorite", book_id, user_id
        self.book.quantity_favorite -= 1
      end
      self.book.save
    end
  end
end
