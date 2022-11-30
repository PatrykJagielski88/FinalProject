class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  # require 'json'
  # require 'sinatra'
  require 'stripe'

  def show
    # Set your secret key. Remember to switch to your live secret key in production.
    # See your keys here: https://dashboard.stripe.com/apikeys
    # Stripe.api_key = 'sk_test_51M1ax1L2ueONTSjVCSyhhaQHc03Hnfsa7k4GImhiBNRmHFPwPzUR1BJndmx2acWqmefDzR5aDJjiuEMIdU60vI7d0052tyhu82'
    current_user.set_payment_processor :stripe
    current_orderable = @cart.orderables.find_by(params[:product_id])
    orderables = @cart.orderables.all # post '/create-checkout-session' do
    item_list = []

    orderables.each do |_ord|
      item_list.append(
        {
          price_data: {
            currency: 'cad',
            unit_amount: _ord.product.price.to_i * 100,
            product_data: {
              name: _ord.product.name
            },
            tax_behavior: 'exclusive'
          },
          quantity: _ord.quantity
        }
      )
      # quan += _ord.to
    end

    str_of_prod = item_list.to_json

    @checkout_session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: JSON.parse(str_of_prod), # tutaj jakos naprawic!
      automatic_tax: {
        enabled: true
      },

      mode: 'payment',
      # These placeholder URLs will be replaced in a following step.
      success_url: 'http://127.0.0.1:3000/checkout/success',
      cancel_url: 'http://127.0.0.1:3000'
    )
    # redirect_to(@checkout_session.url, allow_other_host: true)
  end

  def success
    @success = true

    unless current_user.customer.id
      Customer.create(
        first_name: current_user.first_name,
        last_name: current_user.last_name,
        address: current_user.address,
        city: current_user.city,
        province_id: current_user.province_id,
        user_id: current_user.id
      )
    end

    @current_order = Order.create(
      customer_id: current_user.customer.id
    )

    current_user.set_payment_processor :stripe
    orderables = @cart.orderables.all
    # @curr_cust_id = Order.where('customer_id = ?', current_user.customer.id).limit(1)

    orderables.each do |order|
      ProductDetail.create(
        price_per_one: order.product.price,
        quantity: order.quantity,
        product_id: order.product_id,
        order_id: @current_order.id
      )
    end
  end
end
