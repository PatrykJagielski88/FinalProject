class ApplicationController < ActionController::Base
  before_action :initialize_session
  # helper_method :cart
  before_action :set_render_cart

  def set_render_cart
    @render_cart = true
  end

  private

  def initialize_session
    # session[:shopping_cart] ||= []
    @cart ||= Cart.find_by(id: session[:cart_id])

    if @cart.nil?
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

  # def cart
  #   Product.find(session[:shopping_cart])
  # end
end
