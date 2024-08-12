class User < ApplicationRecord
  MAX_LIKES = 5
  MAX_DISLIKES = 1

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :picture_users, dependent: :delete_all
end
