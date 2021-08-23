class ProductsController < ApplicationController
  
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def show
  end

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
    params.require(:params).permit(:name, :description, :price, :active)
  end
end
