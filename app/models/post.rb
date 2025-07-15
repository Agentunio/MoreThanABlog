class Post < ApplicationRecord
  has_one_attached :main_image
  has_rich_text :content
  belongs_to :user

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  validates :main_image, presence: { message: "Główne zdjęcie musi zostać dodane"}
  validates :title, uniqueness: { message: "Tytuł musi być unikatowy"}, presence: { message: "Tytuł musi zostać dodany" }
end
