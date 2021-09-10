class ReviewsController < ApplicationController
  before_action :find_store
  before_action :find_review, only: [:edit, :update, :destroy]
  # before_action :authenticate_user!, only: [:new, :edit]

  def new
    @review = Review.new
    authorize @review
  end

  def create
    @store = Store.find(params[:store_id])
    @review = @store.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      respond_to do |format|
        format.html { redirect_to @store }
        format.js
      end
    else
      flash[:alert] = "Algo no funcionó correctamente."
      render :new
    end
    authorize @review
  end

  def edit
    authorize @review
  end

  def update
    if @review.update(review_params)
      redirect_to store_path(@store)
    else
      render :edit
    end
    authorize @review
  end

  def destroy
    @review.destroy
    redirect_to store_path(@store) # SOLUCIONAR = Queremos redireccionar a la tienda
    authorize @review
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def find_store
    @store = Store.find(params[:store_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end
end
