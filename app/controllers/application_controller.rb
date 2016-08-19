class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  # include HttpAcceptLanguage::AutoLocale
  # require 'http_accept_language'

  before_filter :set_locale

  private

  def set_locale
    I18n.locale = if current_user
       current_user.locale
     elsif params[:locale]
       session[:locale] = params[:locale]
     elsif session[:locale]
       session[:locale]
     else
       http_accept_language.compatible_language_from(I18n.available_locales)
    end
  end

  def require_login
    unless logged_in?
      flash[:error] = I18n.t("user.error")
      redirect_to login_path
    end
  end


end

