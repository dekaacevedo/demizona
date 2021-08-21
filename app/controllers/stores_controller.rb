class StoresController < ApplicationController

  before_action :set_store, only: [:show]

  def index

    @stores = Store.geocoded # trae stores´s que tengan latitude y longitude obtenidas con la gema
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

private

  def set_store
    @store = Store.find(params[:id])
  end
end