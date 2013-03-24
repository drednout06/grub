module Api
  module V1

    class RestaurantsController < ApplicationController
      respond_to :json

      def index
        @restaurants = Restaurant.all
        respond_with @restaurants
      end

      def search
      end

      def show
        @restaurant = Restaurant.find(params[:id])
        respond_with @restaurant
      end
    end
    
  end
end