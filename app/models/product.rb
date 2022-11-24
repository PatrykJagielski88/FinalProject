class Product < ApplicationRecord
  belongs_to :category
  has_many :product_details
  has_many :orders, through: :product_details
  has_one_attached :image
  has_many :orderables
  has_many :carts, through: :orderables
  validates :name, presence: true
end
