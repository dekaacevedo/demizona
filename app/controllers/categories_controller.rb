class CategoriesController < ApplicationController
  before_action :set_category , only: :show
  def show
    @products = @category.products
    @pagy, @products = pagy(Product,items: 10)
    @cart_item = current_cart.cart_items.new
  end


  private

  def set_category
    @category = Category.find(params[:id])
    authorize @category
  end
end
