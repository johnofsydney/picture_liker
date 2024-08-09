class PictureUsersController < InheritedResources::Base

  def like
    record.update(like: !record.like, dislike: false)

    redirect_to pictures_url
    # TODO - use turbo to replace the buttons
    # head :no_content
  end

  def dislike
    record.update(like: false, dislike: !record.dislike)

    redirect_to pictures_url
    # TODO - use turbo to replace the buttons
    # head :no_content
  end

  private

  def record
    PictureUser.find_or_create_by(
      picture_id: params[:picture_id],
      user_id: current_user.id
    )
  end

    def picture_user_params
      params.require(:picture_user).permit(:picture_id, :user_id, :like, :dislike)
    end

end
