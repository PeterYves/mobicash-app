class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    before_validation { email.downcase! }  
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    has_many :customers, dependent: :destroy
end
