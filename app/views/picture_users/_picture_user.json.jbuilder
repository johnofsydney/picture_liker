json.extract! picture_user, :id, :picture_id, :user_id, :like, :dislike, :created_at, :updated_at
json.url picture_user_url(picture_user, format: :json)
