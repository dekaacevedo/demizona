class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :find_store, only: [:new, :create]

  def index
    products = policy_scope(Product)
    if params[:q]
      @pagy, @products = pagy(@q.result(distinct: true), items: 25)
      @q = Product.ransack(params[:q])
    else
      @pagy, @products = pagy(policy_scope(Product), items: 25)
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
    @product.category_ids = params[:product][:category_ids]

    if @product.save
      redirect_to admin_store_path(@product.store)
    else
      flash[:alert] = "Algo no funcionó correctamente."
      render :new
    end
    authorize @product
  end

  def edit
  end

  def update
    if @product.update(product_params)
      @product.category_ids = params[:product][:category_ids]
      redirect_to admin_store_path(@product.store)
      flash[:notice] = "El producto ha sido actualizado con éxito."
    else
      flash[:alert] = "Algo no funcionó correctamente."
      render :edit
    end
  end

  def destroy
    if @product.destroy
      redirect_to admin_store_path(@product.store)
      flash[:notice] = "El producto ha sido eliminado."
    else
      redirect_to admin_store_path(@product.store)
      flash[:alert] = "Algo no funcionó correctamente."
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
    authorize @product
  end

  def product_params
    params.require(:product).permit(:name, :description, :sku, :price, :discount_price, :active, :featured, :unit_type, :quantity_stock, :discount, :category_ids, photos: [])
  end

  def find_store
    @store = Store.find(params[:store_id])
  end
end
