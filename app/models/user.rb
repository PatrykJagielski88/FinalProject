class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, :province_id, presence: true
  validates :province_id, numericality: { only_integer: true }

  pay_customer stripe_attributes: :stripe_attributes

  belongs_to :province
  has_one :customer

  def stripe_attributes(pay_customer)
    {
      address: {
      },
      metadata: {
        pay_customer_id: pay_customer.id,
        user_id: id
      }
    }
  end
end
