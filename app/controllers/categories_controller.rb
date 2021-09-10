class CategoriesController < ApplicationController
  before_action :set_category , only: :show

  def show
    @pagy, @products = pagy(@category.products,items: 15)
    @cart_item = current_cart.cart_items.new
  end


  private

  def set_category
    @category = Category.find(params[:id])
    authorize @category
  end
end
