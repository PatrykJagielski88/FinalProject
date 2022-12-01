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
    # current_orderable = @cart.orderables.find_by(params[:product_id])
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
      success_url: 'http://127.0.0.1:3000/checkouts/success',
      cancel_url: 'http://127.0.0.1:3000'
    )
    # redirect_to(@checkout_session.url, allow_other_host: true)
  end

  def success
    @success = true

    unless current_user.customer.id
      cust = Customer.create(
        first_name: current_user.first_name,
        last_name: current_user.last_name,
        address: current_user.address,
        city: current_user.city,
        province_id: current_user.province_id,
        user_id: current_user.id
      )

      cust.save
    end

    orderables = @cart.orderables.all

    list_of_prods = []
    orderables.each do |ord|
      list_of_prods.append(ord.product.name)
    end

    prods = list_of_prods.join(',')

    taxes = (@cart.total * 0.12)

    current_order = Order.create(
      customer_id: current_user.customer.id,
      list_of_products: prods,
      grand_total: @cart.total.to_i + taxes,
      taxes: taxes
    )

    current_order.save unless current_order.id

    # current_user.set_payment_processor :stripe
    # @curr_cust_id = Order.where('customer_id = ?', current_user.customer.id).limit(1)

    orderables.each do |order|
      prod_det = ProductDetail.create(
        price_per_one: order.product.price,
        quantity: order.quantity,
        product_id: order.product_id,
        order_id: current_order.id
      )

      prod_det.save
    end

    orderables.each do |to_dest|
      to_dest.destroy
    end

    redirect_to root_path

    testing = Stripe::Event.list({ limit: 3 })

    puts 'here'
    puts testing['data'][0]['id']
  end
end
