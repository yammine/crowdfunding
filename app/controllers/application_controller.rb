class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_action :set_access_controller_headers

  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] if params[:locale]
  end

  def default_url_options(options={})
    {locale: I18n.locale}
  end

  def set_access_controller_headers
    headers['Access-Control-Allow-Origin']   = '*'
    headers['Access-Control-Request-Method'] = '*'
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticate_user!
    redirect_to new_session_path, alert: "You must be signed in." if current_user.nil?
  end

  def authenticate_admin_user!
    true
  end

  def current_admin_user
    nil
  end

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?
  
end
