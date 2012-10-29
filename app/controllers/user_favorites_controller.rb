class UserFavoritesController < InheritedResources::Base
	before_filter :authenticate_user!

	def index
		@favorites = current_user.favorites	
	end

	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
		@favorited = true
		if current_user.favorites.include?(@restaurant)
			current_user.favorites.delete(@restaurant)
			@favorited = false
		else
			current_user.favorites << @restaurant
		end
	end
end
