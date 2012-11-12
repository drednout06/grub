class Cart < ActiveRecord::Base
  attr_accessible :restaurant_id

  belongs_to :restaurant
  has_many :line_items, dependent: :destroy

  def add_dish(dish_id)
		current_item = line_items.find_by_dish_id(dish_id)
		if current_item
    	current_item.quantity += 1
		else
	    current_item = line_items.build(dish_id: dish_id)
		end
	  current_item
	end

	def total_price
		line_items.to_a.sum {|item| item.total_price }
	end

	def total_price_to(district_id)
		restaurant.delivery_fee(district_id).to_i +
		line_items.to_a.sum {|item| item.total_price }
	end

	def enough?
		restaurant.minimum_order <= total_price
	end

	def remainder
		restaurant.minimum_order - total_price
	end

end
# == Schema Information
#
# Table name: carts
#
#  id         :integer         not null, primary key
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

