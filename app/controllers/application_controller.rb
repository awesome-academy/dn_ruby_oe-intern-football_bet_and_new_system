class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def logged_in_user
    action_if_not_logged_in unless user_signed_in?
  end

  def action_if_not_logged_in
    store_location
    flash[:danger] = t "notification.log_in.request"
    redirect_to login_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :password)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :current_password)
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    locale = params[:locale].to_s.strip.to_sym
    d_local = I18n.default_locale
    I18n.locale = I18n.available_locales.include?(locale) ? locale : d_local
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
