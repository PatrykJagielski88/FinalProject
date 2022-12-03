class Province < ApplicationRecord
  has_many :customers

  validates :name, :pst, :gst, :hst, presence: true
  validates :pst, :gst, :hst, numericality: true
end
