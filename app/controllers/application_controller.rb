class ApplicationController < ActionController::Base
  before_action :set_render_cart
  before_action :initialize_session
  # helper_method :cart

  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

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

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:province_id, :email, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:province_id, :email, :password, :current_password)}
  end

  # def cart
  #   Product.find(session[:shopping_cart])
  # end
end
