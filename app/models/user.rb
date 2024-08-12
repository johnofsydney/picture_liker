class User < ApplicationRecord
  MAX_LIKES = 5
  MAX_DISLIKES = 1

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :picture_users, dependent: :delete_all

  def likes
    PictureUser.where(user_id: self.id, like: true).count
  end

  def dislikes
    PictureUser.where(user_id: self.id, dislike: true).count
  end
end
