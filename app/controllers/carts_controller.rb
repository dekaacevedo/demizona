class CartsController < ApplicationController

  def show
    @cart_items = current_cart.cart_items
    authorize current_cart
  end

end
