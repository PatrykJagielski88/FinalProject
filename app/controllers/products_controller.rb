class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).includes(:category).all
  end

  def show
    @product = Product.find(params[:id])
  end
end
