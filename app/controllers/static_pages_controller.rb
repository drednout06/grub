# encoding: utf-8
class StaticPagesController < ApplicationController
  def home
    # if user_signed_in?
    #   if current_user.restaurateur?
    #     restaurants
    #   else
    #     render action: 'restaurants/index'
    #   end
    # end
  	@q = Restaurant.ransack(params[:q])
  	@default_city = City.find_by_name("Алматы")
  end

  def help
  end

  def about
  end

  def contact
  end
end
