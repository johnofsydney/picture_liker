require 'aws-sdk-rekognition'

class Rekognition

  BUCKET = 'arent-pyke-bucket'
  REGION = 'ap-southeast-2'.freeze

  attr_reader :photo

  def initialize(photo)
    # photo is the key of an object (image) in the bucket
    @photo = photo
  end

  def detect_labels
    client.detect_labels(
      image: {
        s3_object: {
          bucket: BUCKET,
          name: photo
        }
      },
      max_labels: 10
    )
  end

  def client
    @client ||= Aws::Rekognition::Client.new(
      region: REGION,
      access_key_id: access_key_id,
      secret_access_key: secret_access_key
    )
  end

  def access_key_id
    Rails.application.credentials.aws[:access_key_id]
  rescue NoMethodError => e
    e.inspect # fix for CI
  end

  def secret_access_key
    Rails.application.credentials.aws[:secret_access_key]
  rescue NoMethodError => e
    e.inspect # fix for CI
  end
end




# https://docs.aws.amazon.com/rekognition/latest/dg/images-s3.html

# # Add to your Gemfile
# # gem 'aws-sdk-rekognition'
# require 'aws-sdk-rekognition'
# credentials = Aws::Credentials.new(
#   ENV['AWS_ACCESS_KEY_ID'],
#   ENV['AWS_SECRET_ACCESS_KEY']
# )
# bucket = 'bucket' # the bucket name without s3://
# photo  = 'photo' # the name of file
# client   = Aws::Rekognition::Client.new credentials: credentials
# attrs = {
#   image: {
#     s3_object: {
#       bucket: bucket,
#       name: photo
#     },
#   },
#   max_labels: 10
# }
# response = client.detect_labels attrs
# puts "Detected labels for: #{photo}"
# response.labels.each do |label|
#   puts "Label:      #{label.name}"
#   puts "Confidence: #{label.confidence}"
#   puts "Instances:"
#   label['instances'].each do |instance|
#     box = instance['bounding_box']
#     puts "  Bounding box:"
#     puts "    Top:        #{box.top}"
#     puts "    Left:       #{box.left}"
#     puts "    Width:      #{box.width}"
#     puts "    Height:     #{box.height}"
#     puts "  Confidence: #{instance.confidence}"
#   end
#   puts "Parents:"
#   label.parents.each do |parent|
#     puts "  #{parent.name}"
#   end
#   puts "------------"
#   puts ""
# end