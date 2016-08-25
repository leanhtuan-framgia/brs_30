class Activity < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy

  scope :order_by, -> {order created_at: :desc}
  scope :user_activity, ->user_ids {where(
    "user_id IN (?)", user_ids)}
end
