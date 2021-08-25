require_relative "../models/store"
# require_relative "../models/category"

class PagesController < ApplicationController

  def home
    @stores = Store.all
    # @categories = Category.all

  end
end
