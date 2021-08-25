class StoresController < ApplicationController
  # before_action :set_user, only: [:new, :create]
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  def index
    stores = policy_scope(Store)
    @stores = stores.geocoded # trae stores´s que tengan latitude y longitude obtenidas con la gema
    @markers = @stores.geocoded.map do |store|
      {
        lat: store.latitude,
        lng: store.longitude,
        info_window: render_to_string(partial: "info_index",
        locals: { store: store }),
        # image_url: helpers.asset_url("marker.png")
      }
    end
  end

  def show

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
      redirect_to store_path(@store), notice: "Su tienda fue creada con éxito."
    else
      redirect_to store_path
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
    # LA RUTA ESTABLECIDA ES PROVISORIA,SE RECOMIENDA redirect_to user_path(@user).
    redirect_to stores_path
  end


  private
  
  # def set_user
   #  @user = User.find(params[:user_id])
  # end

  def set_store
    @store = Store.find(params[:id])
    authorize @store
  end

  def store_params
    params.require(:store).permit(:name, :address, :city, :email, :phone, photos: [])
  end

end