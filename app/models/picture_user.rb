class PictureUser < ApplicationRecord
  belongs_to :picture
  belongs_to :user

  validate :max_likes
  validate :max_dislikes
  validate :like_or_dislike

  def max_likes
    return unless self.like

    current_likes = PictureUser.where(user_id:, like: true).count
    return unless current_likes >= User::MAX_LIKES

    errors.add(:base, "You can only like #{User::MAX_LIKES} #{'picture'.pluralize(User::MAX_LIKES)}")
  end

  def max_dislikes
    return unless self.dislike

    current_likes = PictureUser.where(user_id:, dislike: true).count
    return unless current_likes >= User::MAX_DISLIKES

    errors.add(:base, "You can only dislike #{User::MAX_DISLIKES} #{'picture'.pluralize(User::MAX_DISLIKES)}")
  end

  def like_or_dislike
    if like && dislike
      errors.add(:like, "You can't like and dislike a picture at the same time")
    end
  end
end

