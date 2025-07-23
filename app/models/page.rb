class Page < ApplicationRecord
  has_ancestry
  has_rich_text :content
  
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  validates :slug, presence: true, uniqueness: true

  scope :in_nav, -> { where(in_nav: true) }

  def full_slug
    path.map(&:slug).join("/")
  end
end
