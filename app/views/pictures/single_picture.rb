class Pictures::SinglePicture < Phlex::HTML
  include Phlex::Rails::Helpers::DOMID
  include Phlex::Rails::Helpers::ImageTag

  attr_accessor :picture

  def initialize(picture:)
    @picture = picture
  end

  def view_template
    div(id: (dom_id picture)) do
      image_tag picture.main_image.variant(resize_to_limit: [450, nil])
    end
  end
end