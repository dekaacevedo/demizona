require_relative "../models/store"
# require_relative "../models/category"

class PagesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:home]

  def home
    @stores = Store.all
    # @categories = Category.all

  end
end
