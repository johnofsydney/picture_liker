class PictureUsersController < InheritedResources::Base


  def like
    record.update(like: !record.like, dislike: false)

    redirect_to pictures_url, notice:

    # TODO - use turbo to replace the buttons
    # head :no_content
  end

  def dislike
    record.update(like: false, dislike: !record.dislike)

    redirect_to pictures_url, notice:

    # TODO - use turbo to replace the buttons
    # head :no_content
  end

  private

  def notice
    return record.errors.full_messages.join(", ") if record.errors.any?

    "#{User::MAX_LIKES - number_of_likes}/#{User::MAX_LIKES} likes remaining, #{User::MAX_DISLIKES - number_of_dislikes}/#{User::MAX_DISLIKES} dislikes remaining."
  end

  def number_of_likes
    PictureUser.where(user_id: current_user.id, like: true).count
  end

  def number_of_dislikes
    PictureUser.where(user_id: current_user.id, dislike: true).count
  end

  def record
    @record ||= PictureUser.find_or_create_by(
      picture_id: params[:picture_id],
      user_id: current_user.id
    )
  end

    def picture_user_params
      params.require(:picture_user).permit(:picture_id, :user_id, :like, :dislike)
    end
end
