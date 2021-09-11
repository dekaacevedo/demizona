require_relative "../models/store"
class InfosController < ApplicationController


  def questions
    stores = policy_scope(Store)
    @stores = current_user.stores
    authorize  @stores
  end

end
