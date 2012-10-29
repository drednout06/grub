module CartsHelper

	def current_cart
		Cart.find(session[:cart_id])
	rescue ActiveRecord::RecordNotFound
		nil
	end

	def create_cart_for(restaurant)
		cart = restaurant.carts.create
		session[:cart_id] = cart.id
		cart
	end

end
