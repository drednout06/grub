module Api
	module V1

		class CitiesController < ApplicationController

			respond_to :json
		  
		  def index
		    @cities = City.all
				respond_with @cities
		  end

		  # GET /cities/1
		  # GET /cities/1.json
		  def show
		    @city = City.find(params[:id])
		    respond_with @city
		  end

		end


	end
end