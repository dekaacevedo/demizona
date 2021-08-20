class ReviewsController < ApplicationController
  before_action :find_store
  before_action :find_review, only: [:edit, :update, :destroy]
  
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.store_id = @store.id
    @review.user_id = 1
    # Change for current user

    if @review.save!
      redirect_to store_path(@store)
    else
      render 'new'
    end      
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to store_path(@book)
    else
      render 'edit'
    end
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
