class Order < ApplicationRecord
  belongs_to :customer
  has_many :product_details
  has_many :products, through: :product_details

  validates :customer_id, :list_of_products, :grand_total, :taxes, presence: true
  validates :customer_id, numericality: { only_integer: true }
  validates :grand_total, :taxes, numericality: true
end
