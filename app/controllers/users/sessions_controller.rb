class Users::SessionsController < Devise::SessionsController
  respond_to :html, :js

  def create
    super
  end
end
