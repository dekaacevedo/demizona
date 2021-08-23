require_relative "../models/store"

class PagesController < ApplicationController

  def home
    @stores = Store.all
  end
end
