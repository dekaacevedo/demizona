class CartsController < ApplicationController

  def show
    @cart_items = current_cart.cart_items
    @order = Order.new
    authorize current_cart
  end

end
