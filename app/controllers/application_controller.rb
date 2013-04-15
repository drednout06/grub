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

  rescue_from CanCan::AccessDenied do |exception|
    # render file: "#{Rails.root}/public/403", formats: [:html], status: 403, layout: false
    redirect_to root_url, :alert => exception.message
  end

  private

		def set_locale
		  I18n.locale = params[:locale] || cookies[:locale] || extract_locale_from_tld || I18n.default_locale
		  cookies.permanent[:locale] = I18n.locale
		end

		def default_url_options(options = {})
		  {locale: I18n.locale}
		end

    def extract_locale_from_tld
      parsed_locale = request.host.split('.').last
      (parsed_locale == "kg") ? :"ru-KG" : nil
    end
end
