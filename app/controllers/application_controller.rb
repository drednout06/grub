class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  include CartsHelper
  include DistrictsHelper

  before_filter :set_locale

  def authenticate_active_admin_user!
    authenticate_user! 
    unless current_user.admin?
      flash[:alert] = "Unauthorized Access!"
      redirect_to root_path 
    end
  end


  private

		def set_locale
		  I18n.locale = params[:locale] || cookies[:locale] || I18n.default_locale
		  cookies.permanent[:locale] = I18n.locale
		end

		def default_url_options(options = {})
		  {locale: I18n.locale}
		end
end
