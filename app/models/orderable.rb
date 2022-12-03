class Orderable < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :product_id, :cart_id, :quantity, presence: true
  validates :product_id, :cart_id, :quantity, numericality: { only_integer: true }

  def total
    product.price.to_i * quantity
  end
end
