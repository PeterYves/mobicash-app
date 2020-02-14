class Customer < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :products, dependent: :destroy
  validates :name, :address, :phone, presence: true
end
