module ApplicationHelper
   def current_cart
    # Use Find by id to avoid potential errors
    cart = Cart.find_by_id(session[:cart_id])
    return cart if cart
    Cart.new(user: current_user, active: true)
  end
end
