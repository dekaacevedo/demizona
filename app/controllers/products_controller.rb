class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :find_store, only: [:new, :create]

  def index
     @pagy,products = pagy(policy_scope(Product),items: 9)
    if params[:q]
      @q = Product.ransack(params[:q])
      @products = @q.result(distinct: true)
    else
      @products = products
    end
    @cart_item = current_cart.cart_items.new
  end

  def show
    @cart_item = current_cart.cart_items.new
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    @product.store = @store

    if @product.save
      redirect_to admin_store_path(@product.store)
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
    authorize @product
  end

  def edit
  end

  def update
    if @product.update(product_params)
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
    authorize @product
  end

  def product_params
    params.require(:product).permit(:name, :description, :sku, :price, :discount_price, :active, :featured, :unit_type, :quantity_stock, :discount, :description, photos: [])
  end

  def find_store
    @store = Store.find(params[:store_id])
  end
end
