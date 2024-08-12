class PictureUsersController < InheritedResources::Base
  include ActionView::RecordIdentifier # adds `dom_id`

  def like
    # record.update(like: !record.like, dislike: false)

    respond_to do |format|
      if record.update(like: !record.like, dislike: false)
        format.html { redirect_to pictures_url, notice: }
        format.turbo_stream do
          # Pass an array of turbo_streams to the render call
          render turbo_stream:
            [
              # while it would be nice to replace just the button that has been liked,
              # I also want to grey out / disable all of the buttons on the whole page when the user has reached their limit of likes
              turbo_stream.replace("pictures", partial: 'pictures/pictures', locals: { pictures: Picture.all }),
              turbo_stream.replace("notice", partial: 'partials/notice', locals: { notice: })
            ]
        end
      else
        format.html { redirect_to pictures_url, notice: }
      end
    end
  end

  def dislike
    # if you use the arg ', data: { turbo: false }' in the form_with tag,
    # then theoretically you can use the redirect_to plus anchor to scroll to the picture that was just disliked
    # record.update(like: false, dislike: !record.dislike)
    # redirect_to pictures_path, anchor: "picture_#{record.picture.id}", notice:
    # but it doesn't work for me, so I'm using turbo_stream instead

    respond_to do |format|
      if record.update(like: false, dislike: !record.dislike)
        format.html { redirect_to pictures_url, notice: }
        format.turbo_stream do
          render turbo_stream:
            [
              turbo_stream.replace("pictures", partial: 'pictures/pictures', locals: { pictures: Picture.all }),
              turbo_stream.replace("notice", partial: 'partials/notice', locals: { notice: })
            ]
        end
      else
        format.html { redirect_to pictures_url, notice: }
      end
    end
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
