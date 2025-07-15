class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
      belongs_to :role, optional: true
      before_validation :set_default_role, on: :create
      has_many :posts
      private

        def set_default_role
          self.role ||= Role.find_by(name: "Użytkownik")
        end
end
