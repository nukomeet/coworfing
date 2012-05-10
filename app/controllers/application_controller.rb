class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  def default_url_options(options = {})
    {locale: I18n.locale}
  end

  private

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end


end
