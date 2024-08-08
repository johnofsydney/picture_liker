class Pictures::IndexView < Phlex::HTML
  include Phlex::Rails::Helpers::ContentFor
  include Phlex::Rails::Helpers::ImageTag
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::Routes

  attr_accessor :notice

  def initialize(notice: nil, pictures:)
    @notice = notice
    @pictures = pictures
  end

  def view_template
    div(class: "w-full") do
      if notice.present?
        p(
          class: "py-2 px-3 bg-green-50 mb-5 text-green-500 font-medium rounded-lg inline-block",
          id: "notice"
        ) { notice }
      end

      content_for :title, "Pictures"
      div(class: "flex justify-between items-center") do
        h1(class: "font-bold text-4xl") { "Pictures" }
        whitespace
        link_to "New picture",
                new_picture_path,
                class:
                  "rounded-lg py-3 px-5 bg-blue-600 text-white block font-medium"
      end
      div(
        id: "pictures",
        class: "grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 min-w-full"
      ) do
        whitespace
        @pictures.each do |picture|
          p { picture.inspect }
          div(class: "bg-white p-4 rounded-lg shadow flex flex-col justify-between") do
            binding.irb
            render Pictures::SinglePicture.new(picture:)

            div(class: "flex justify-between items-end mt-auto") do
              image_tag "thumbs-up-regular.svg",
                        alt: "Thumbs Up",
                        class: "w-16 h-16"
              image_tag "thumbs-down-regular.svg",
                        alt: "Thumbs Down",
                        class: "w-16 h-16"
            end
          end
        end
      end
    end
  end

  private

  def render(*args, **kwargs)
    # TODO: Implement me
  end
end