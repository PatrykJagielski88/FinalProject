class CartController < ApplicationController
  def show
    @render_cart = false
  end
  # def create
  #   logger.debug("Adding #{params[:id]} to cart")
  #   id = params[:id].to_i

  #   unless session[:shopping_cart].include?(id)
  #     session[:shopping_cart] << id
  #     product = Product.find(id)
  #     flash[:notice] = " #{product.name} added to cart."
  #   end

  #   redirect_to root_path
  # end

  # def destroy
  #   id = params[:id].to_i
  #   session[:shopping_cart].delete(id)
  #   product = Product.find(id)
  #   redirect_to root_path
  #   flash[:notice] = " #{product.name} removed from cart."
  # end
end
