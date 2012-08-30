class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :dish_id, :quantity
  belongs_to :cart
  belongs_to :dish
  belongs_to :order

  def total_price
  	dish.price * quantity
  end

  default_scope :order => 'created_at ASC'

end
# == Schema Information
#
# Table name: line_items
#
#  id         :integer         not null, primary key
#  dish_id    :integer
#  cart_id    :integer
#  quantity   :integer         default(1)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  order_id   :integer
#

