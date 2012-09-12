class Order < ActiveRecord::Base
  attr_accessible :address_id, :change_from, :delivery_time, :address,
                  :address_type, :address_attributes

  has_one :user, through: :address
  belongs_to :restaurant
  belongs_to :address
  accepts_nested_attributes_for :address

  has_many :line_items, dependent: :destroy

  #validates :user, presence: true
  validates :address, presence: true
  

  def add_line_items_from_cart(cart)
  	cart.line_items.each do |item|
  		item.cart_id = nil
  		line_items << item
  	end
  end

end
# == Schema Information
#
# Table name: orders
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  address_id    :integer
#  delivery_time :datetime
#  change_from   :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  restaurant_id :integer
#

