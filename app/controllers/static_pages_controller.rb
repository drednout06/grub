# encoding: utf-8
class StaticPagesController < ApplicationController
  
  def home
  	@q = Restaurant.ransack(params[:q])
    @districts = City.find(1).districts.order(:name)

    respond_to do |format|
      format.html {}
      format.json { City.all.to_json }
    end
  end

  def pizza
    redirect_to restaurants_path(:'q[cuisine_tags_cuisine_id_eq_any][]' => '33')
  end

  def sushi
    redirect_to restaurants_path(:'q[cuisine_tags_cuisine_id_eq_any][]' => '32')
  end

  def chinese
    redirect_to restaurants_path(:'q[cuisine_tags_cuisine_id_eq_any][]' => '50')
  end

  def help
  end

  def about
  end

  def contact
  end

end
