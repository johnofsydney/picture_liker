class Pictures::ShowView < ApplicationView


  attr_reader :picture
  def initialize(picture:)
    @picture = picture
  end
  def view_template
    render Pictures::SinglePicture.new(picture:)
  end
end