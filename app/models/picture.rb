class Picture < ApplicationRecord
  # ACCEPTABLE_TYPES = ActiveStorage.variable_content_types

  has_one_attached :image
  # https://pragmaticstudio.com/tutorials/using-active-storage-in-rails

  has_many :picture_users, dependent: :delete_all
end
