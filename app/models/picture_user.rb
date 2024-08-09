class PictureUser < ApplicationRecord
  belongs_to :picture
  belongs_to :user

  validate :like_or_dislike

  def like_or_dislike
    if like && dislike
      errors.add(:like, "You can't like and dislike a picture at the same time")
    end
  end
end
