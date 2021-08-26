class ApplicationController < ActionController::Base

  include ApplicationHelper

  before_action :configure_permitted_parameters, if: :devise_controller?
  # agregar solo donde sea necesario (carrito)
  before_action :authenticate_user!
  include Pundit

   # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :address, :phone, :seller])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :last_name, :address, :phone, :seller])
  end

  helper_method :resource_name, :resource, :devise_mapping, :resource_class

  #rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  #def user_not_authorized
  #  flash[:alert] = "No estás autorizado para realizar esta acción."
   # redirect_to(root_path)
  #end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end


  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  private
  #<_____------------------------------->
  # Se saltea esto solo cuando está en alguna pantalla de devise(sign_up o sign_in)
  # O algún controller que esté conectado con el admin.
  #<_____------------------------------->
  def skip_pundit?
    # raise
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
