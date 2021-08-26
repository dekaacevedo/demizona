require_relative "../models/cart"
class OrdersController < ApplicationController
  before_action :set_order, only: [:show]

  def index
  end

  def show
    authorize @order
  end

  def create
    @order = Order.new
    @order.user = current_user
    @order.cart = current_cart
    authorize @order
    if @order.save
      redirect_to @order
    else
      # Rechazar pago, redirigir a algún lado
      redirect_to root_path
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

end
