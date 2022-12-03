class ProductDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :price_per_one, :quantity, :product_id, :order_id, presence: true
  validates :product_id, :order_id, :quantity, numericality: { only_integer: true }
  validates :price, numericality: true
end
