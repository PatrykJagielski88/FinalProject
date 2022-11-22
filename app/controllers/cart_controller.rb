class CartController < ApplicationController
  def create
    logger.debug("Adding #{params[:id]} to cart")
    id = params[:id].to_i

    unless session[:shopping_cart].include?(id)
      session[:shopping_cart] << id
      horse = Horse.find(id)
      flash[:notice] = " #{horse.name} added to cart."
    end

    redirect_to root_path
  end

  def destroy
    id = params[:id].to_i
    session[:shopping_cart].delete(id)
    horse = Horse.find(id)
    redirect_to root_path
    flash[:notice] = " #{horse.name} removed from cart."
  end
end
