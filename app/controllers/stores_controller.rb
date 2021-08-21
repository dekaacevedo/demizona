class StoresController < ApplicationController

  before_action :set_store, only: [:show]

  def show
    if @store.reviews.blank?
      @average_review = 0
    else
      @average_review = @store.reviews.average(:rating).round(2)
    end
  end

private

  def set_store
    @store = Store.find(params[:id])
  end
end