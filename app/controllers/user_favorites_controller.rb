class UserFavoritesController < InheritedResources::Base

	def index
		@favorites = @user.favorites	
	end

	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
		current_user.favorites << @restaurant
	end

	def destroy
		@favorite = UserFavorite.find(params[:id])
		@restaurant = @favorite.try(:restaurant)
		@favorite.destroy unless @favorite.blank?
	end
end
