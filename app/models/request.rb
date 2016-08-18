class Request < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :author, presence: true
  validates :publish_date, presence: true
  validate :validates_publish_date_compare_now

  enum req_status: [:pendding, :accept, :reject]

  private
  def validates_publish_date_compare_now
    errors.add :publish_date, I18n.t("errors.publish_date") if
      publish_date.to_date > Time.now.to_date
  end
end
