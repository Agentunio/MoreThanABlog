class Role < ApplicationRecord
  has_many :users
  validates :name, presence: { message: "Musisz podać nazwę roli" }
end
