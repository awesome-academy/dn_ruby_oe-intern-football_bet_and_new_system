class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :store_user_location!, if: :storable_location?
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def self.default_url_options options = {}
    options.merge(locale: I18n.locale)
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :password)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :current_password)
    end
  end

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    d_local = I18n.default_locale
    I18n.locale = I18n.available_locales.include?(locale) ? locale : d_local
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? &&
      !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end
end
