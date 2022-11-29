class Customer < ApplicationRecord
  has_many :orders, dependent: :destroy
  belongs_to :province
  belongs_to :user
end
