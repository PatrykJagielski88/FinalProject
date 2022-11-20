class Product < ApplicationRecord
  belongs_to :category
  has_many :product_details
  has_many :orders, through: :product_details
  has_one_attached :image
  validates :name, presence: true
end
