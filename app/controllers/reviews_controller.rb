class ReviewsController < ApplicationController
  before_action :find_store,  except: %i[destroy]
  before_action :find_review, only: [:edit, :update, :destroy]
  # before_action :authenticate_user!, only: [:new, :edit]

  def new
    @review = Review.new
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    @review.store = @store
    @review.user = current_user

    if @review.save
      redirect_to store_path(@review.store)
    else
      flash[:alert] = "Something went wrong."
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
    redirect_to stores_path # SOLUCIONAR = Queremos redireccionar a la tienda
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
