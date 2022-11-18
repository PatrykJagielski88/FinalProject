class Order < ApplicationRecord
  belongs_to :customer
  has_many :product_details
  has_many :products, through: :product_details
end
