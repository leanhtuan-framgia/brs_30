class User < ApplicationRecord
  has_many :user_books, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  before_save :downcase_email

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}
  VALID_PHONE_REGEX = /\d[0-9]\)*\z/
  validates :phone_number, presence: true, numericality: true,
    length: {minimum: 10, maximum: 11},
    format: {with: VALID_PHONE_REGEX}

  enum gender: {male: 0, female: 1}

  def current_user? user
    self == user
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

  def feeds
    user_ids = self.following.map &:id
    user_ids << id
    Activity.user_activity user_ids
  end

  private
  def downcase_email
    self.email = email.downcase
  end
end
