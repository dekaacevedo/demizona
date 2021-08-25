require_relative "../models/store"
require_relative "../models/product"
# require_relative "../models/category"

class PagesController < ApplicationController

  def home
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
    @stores = Store.all
    # @categories = Category.all

  end
end
