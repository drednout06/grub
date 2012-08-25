class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :dish_id, :quantity
  belongs_to :cart
  belongs_to :dish

  def total_price
  	dish.price * quantity
  end

  default_scope :order => 'created_at ASC'

end
