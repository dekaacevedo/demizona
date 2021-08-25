module ApplicationHelper
   def current_cart
    # Use Find by id to avoid potential errors
    if Cart.find_by_id(session[:cart_id]).nil?
      Cart.new(user: current_user, active: true)
    else
      Cart.find_by_id(session[:cart_id])
    end
  end
end
