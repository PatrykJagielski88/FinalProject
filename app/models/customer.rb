class Customer < ApplicationRecord
  has_many :orders, dependent: :destroy
  belongs_to :province
  belongs_to :user

  validates :province_id, :user_id, presence: true
  validates :province_id, :user_id, numericality: { only_integer: true }
end
