class Picture < ApplicationRecord
  has_one_attached :main_image
  # https://pragmaticstudio.com/tutorials/using-active-storage-in-rails
end
