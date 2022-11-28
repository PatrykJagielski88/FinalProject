class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).includes(:category).all
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"

    @products_s = if params[:category_id] == ''
                    Product.page(params[:page]).where('name LIKE ?', wildcard_search)
                  else
                    Product.page(params[:page]).where('name LIKE ? and category_id LIKE ?', wildcard_search,
                                                      params[:category_id])
                  end
  end
end
