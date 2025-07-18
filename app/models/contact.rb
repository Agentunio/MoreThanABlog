class Contact < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/ }
  validates :subject, presence: true
  validates :message, presence: true
end
