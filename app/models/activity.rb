class Activity < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy

  scope :order_by, -> {order created_at: :desc}
end
