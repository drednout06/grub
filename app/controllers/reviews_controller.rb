class ReviewsController < InheritedResources::Base
	belongs_to :restaurant
	def index
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = @restaurant.reviews.where(user_id: current_user.id).first || Review.new
		index!
	end

	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
		params[:review][:user_id] = current_user.id
		@review = @restaurant.reviews.build(params[:review])
		
		if @review.save
			redirect_to restaurant_reviews_path(@restaurant), notice: ''
		else
			@reviews = @restaurant.reviews
			render action: 'index'
		end
	end

end
