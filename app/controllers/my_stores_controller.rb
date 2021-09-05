require_relative "../models/store"

class MyStoresController < ApplicationController

  def index
    stores = policy_scope(Store)
    @stores = current_user.stores
  end
end
