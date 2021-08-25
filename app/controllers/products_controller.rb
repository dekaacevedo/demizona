class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    products = policy_scope(Product)
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
    @cart_item = current_cart.cart_items.new
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.save
  end

  def edit
  end

  def update
    @product.update(product_params)
  end

  def destroy
    @product.destroy
  end

private

  def set_product
    @product = Product.find(params[:id])
  end

  def products_params
    params.require(:params).permit(:name, :description, :price, :active, photos: [])
  end
end
