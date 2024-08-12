class AddPhotosJob
  include Sidekiq::Job

  def perform(picture_params)
  end
end
