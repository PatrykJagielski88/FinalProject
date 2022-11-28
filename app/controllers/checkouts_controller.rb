class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  # require 'json'
  # require 'sinatra'
  require 'stripe'
  def go_to_checkout; end

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
      cancel_url: 'https://example.com/cancel'
    )
    # redirect_to(@checkout_session.url, allow_other_host: true)
  end

  # end

  # @products = Product.page(params[:page]).includes(:category).all
  # prod = @products.find(204)
  # current_user.set_payment_processor :stripe
  # current_user.set_payment_processor.customer

  # @checkout_session = current_user
  #                     .payment_processor
  #                     .checkout(
  #                       mode: 'payment',
  #                       line_items: [
  #                         price: prod.price
  #                       ]
  #                     )
  # @checkout_session = Stripe::Checkout::Session.create(
  #   payment_method_types: ['card'],
  #   success_url: checkout_success_path,
  #   cancel_url: checkout_cancel_path,
  #   line_items: [
  #     price: prod.price
  #   ]
  # )
  # end

  def success
    @success = true
  end
end
