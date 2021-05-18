class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :likes
  has_many :friends
  scope :tweets_for_me, ->(user) { Tweet.where(user_id: user.friends.pluck(:friend_id).uniq) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
end
