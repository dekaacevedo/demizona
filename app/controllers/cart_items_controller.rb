class CartItemsController < ApplicationController

  before_action :set_cart

  def create
    @cart_items = @cart.cart_items.new(cart_items_params)
    match = @cart.cart_items.where(product_id: @cart_items[:product_id])
    if match.size == 0
      @cart.save
    else
      match.first.update(quantity: match.first.quantity + @cart_items[:quantity])
    end
    
    session[:cart_id] = @cart.id
    authorize @cart_items
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end

  def update
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.update_attributes(cart_items_params)
    @cart_items = current_cart.cart_items
    authorize @cart_items
    if @cart_item.quantity == 0
      @cart_item.destroy
    end
    redirect_to request.referrer
  end

  def destroy
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy
    @cart_items = current_cart.cart_items
    authorize @cart_items
  end

  private

  def cart_items_params
    params.require(:cart_item).permit(:quantity, :item_price, :product_id, :cart_id)
  end

  def set_cart
    @cart = current_cart
  end
end
