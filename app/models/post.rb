class Post < ApplicationRecord
  has_one_attached :main_image
  has_rich_text :content
  belongs_to :user

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  validates :main_image, presence: true
  validates :title, uniqueness: true, presence: true
  validate :custom_date_cannot_be_in_future
  validate :main_image_type

  private

  def main_image_type
    return unless main_image.attached?

    unless main_image.blob&.content_type&.in?(%w[image/jpeg image/png image/webp image/jpg])
      errors.add(:main_image, :invalid_format)
    end
  end


  def custom_date_cannot_be_in_future
    if custom_date.present? && custom_date > Date.today
      errors.add(:custom_date, :invalid_date)
    end
  end

end
