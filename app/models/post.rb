class Post < ApplicationRecord
  has_one_attached :main_image
  has_rich_text :content
end
