class OrdersController < ApplicationController

  #before_action :orders_params, only: [:show,:create]
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

  def update
    #status es order
  end

  private

  #def orders_params
   # params.require(:order).permit(:status)
  #end

  def set_order
    @order = Order.find(params[:id])
  end

end
