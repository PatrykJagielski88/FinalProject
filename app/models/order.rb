class Order < ApplicationRecord
  belongs_to :customers
  has_many :product_details
  has_many :productscontroller, through: :product_details
end
