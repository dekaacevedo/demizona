class ProductsController < ApplicationController
  
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :find_store, only: [:new, :create]

  def index
  end

  def show
    @store = Store.where(id:@product.store_id)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(products_params)
    @product.store = @store

    if @product.save
      redirect_to admin_store_path(@product.store)
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  def edit    
  end

  def update
    if @product.update(products_params)
      redirect_to admin_store_path(@product.store)
      flash[:alert] = "Product updated succesfully"
    else
      flash[:alert] = "Something went wrong"
      render :edit
    end
  end

  def destroy
    if @product.destroy
      redirect_to admin_store_path(@product.store)
      flash[:alert] = "Product deleted"
    else
      redirect_to admin_store_path(@product.store)
      flash[:alert] = "Something went wrong"
    end
  end

private

  def set_product
    @product = Product.find(params[:id])
  end

  def products_params
    params.require(:product).permit(:name, :description, :sku, :price, :old_price, :active, :featured, :unit_type, :quantity_stock, :discount, :description, photos: [])
  end

  def find_store
    @store = Store.find(params[:store_id])
  end
end
