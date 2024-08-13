class AddPhotosJob
  include Sidekiq::Job

  def perform(path, filename)
    picture = Picture.new
    picture.image.attach(io: File.open(path), filename: filename)
    picture.save!
  end
end
# fails because the tempfile is, well, temporary and is deleted after the request is done.