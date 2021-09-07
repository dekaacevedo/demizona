require_relative "../models/cart"
class OrdersController < ApplicationController
  include PaymentHelper

  before_action :set_order, only: [:show]
  def index
    orders = policy_scope(Order)
    @orders = current_user.orders
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
      payment_information = create_new_payment(@order.cart.total_price)
      if payment_information.payment_id
        session[:cart_id] = nil
        @order.payment_id = payment_information.payment_id
        @order.paid = true
        @order.save
      else
        # Rechazar pago, redirigir a algún lado
      end
      redirect_to @order
    else
      # Rechazar pago, redirigir a pagina de pago rechazado
      redirect_to root_path
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
