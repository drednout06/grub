class Cart < ActiveRecord::Base
  # attr_accessible :title, :body
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

end
