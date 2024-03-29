require_relative "../models/user"
require_relative "../models/store"
class StoresController < ApplicationController

  # before_action :set_user, only: [:new, :create]
  before_action :set_store, only: [:show, :edit, :update, :destroy, :admin]

  def index
    @pagy, stores = pagy(policy_scope(Store), items: 6)
    @stores = stores.geocoded # trae stores´s que tengan latitude y longitude obtenidas con la gema
    @markers = @stores.geocoded.map do |store|
      {
        lat: store.latitude,
        lng: store.longitude,
        info_window: render_to_string(partial: "info_index",
        locals: { store: store })
      }
    end
  end

  def show
    @cart_item = current_cart.cart_items.new
    admin
    @review = Review.new

    if @store.reviews.blank?
      @average_review = 0
    else
      @average_review = @store.reviews.average(:rating).round(2)
    end
    @markers = [
      {
        id: @store.id,
        lat: @store.latitude,
        lng: @store.longitude,
        info_window: render_to_string(partial: "info_window",
        locals: { store: @store })
      }
    ]

  end

  def new
      @store = Store.new
      authorize @store
  end

  def create
    @store = Store.new(store_params)
    @store.user = current_user
    authorize @store

    # Si la tienda se crea con éxito será redireccionado a su show,
    #   en caso contrario será redireccionado a las tiendas.
    if @store.save
      if !current_user.seller
        current_user.make_it_a_seller!
        current_user.save
      end
      @store.save
      redirect_to store_path(@store), notice: "Su tienda fue creada con éxito."
    else
      render :new
    end
  end

  def edit
  end

  def update
    @store.update(store_params)
    redirect_to store_path(@store)
  end

  def destroy
    # Si la tienda se elimina, el usuario será redireccionado a su perfil.
    @store.destroy
    @stores_number = current_user.stores.size
    if @stores_number == 0
      current_user.make_it_a_not_seller!
      current_user.save
    end
    # LA RUTA ESTABLECIDA ES PROVISORIA,SE RECOMIENDA redirect_to user_path(@user).
    redirect_to stores_path
  end

  def admin
    @pagy, @products = pagy(@store.products,items: 12)
  end

private

  #def set_user
    # @user = User.find(params[:user_id])
  # end


  def set_store
    @store = Store.find(params[:id])
    authorize @store
  end

  def store_params
    params.require(:store).permit(:name, :address, :city, :email, :phone, photos: [])
  end
end
