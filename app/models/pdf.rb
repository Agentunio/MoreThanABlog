class Pdf < ApplicationRecord
  has_one_attached :file
  validates :url, presence: true, uniqueness: true
end
