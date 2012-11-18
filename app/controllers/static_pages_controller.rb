# encoding: utf-8
class StaticPagesController < ApplicationController
  
  def home
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
