class FetchLabelsJob
  include Sidekiq::Job

  def perform(picture_ids)
    return unless Rails.env.production?

    Picture.where(id: picture_ids).find_each do |picture|
      p "find labels with rekognition for picture #{picture.id}"

      labels = Rekognition.new(picture.image.blob.key).detect_labels.labels
      confident_labels = []

      labels.each do |label|
        confident_labels << label.name if label.confidence > 95
      end
    end

    picture.update!(labels: confident_labels.join(', '))
  end
end


# rek = Rekognition.new('0chsqepd7jpgxdxnj3o6ye76wt2c')
# response = rek.detect_labels

# 3.2.2 :024 > response.labels.each do |label|
# 3.2.2 :025 >   p "name: #{label.name}"
# 3.2.2 :026 >   p "confidence: #{label.confidence}"
# 3.2.2 :027 >   p "parents: #{label.parents&.first.name}"
# 3.2.2 :028 > end

# "name: Logo"
# "confidence: 99.49008178710938"
# "parents: "
# "name: Smoke Pipe"
# "confidence: 87.84519958496094"
# "parents: "
# "name: Outdoors"
# "confidence: 72.17317962646484"
# "parents: "
# "name: Nature"
# "confidence: 69.18984985351562"
# "parents: Outdoors"
# "name: Sea"
# "confidence: 69.18984985351562"
# "parents: Nature"
# "name: Text"
# "confidence: 64.998779296875"
# "parents: "
# "name: Sticker"
# "confidence: 57.772857666015625"
# "parents: "
# "name: Light"
# "confidence: 57.75476837158203"
# "parents: "
# "name: Coffee Cup"
# "confidence: 56.65473175048828"
# "parents: Beverage"
# "name: Fruit"
# "confidence: 56.411224365234375"
# "parents: Food"



