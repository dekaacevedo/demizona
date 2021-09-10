require_relative "../models/store"
require_relative "../models/product"
# require_relative "../models/category"

class PagesController < ApplicationController

  skip_before_action :authenticate_user!, only: :home
  def home
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
    @stores = Store.all
    # @categories = Category.all
    @cart_item = current_cart.cart_items.new
    @featured_products = Product.where(featured: true).sample(5)
  end
end
