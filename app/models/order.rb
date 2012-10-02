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

class Order < ActiveRecord::Base
  attr_accessible :address_id, :change_from, :delivery_time, :address,
                  :address_type, :address_attributes, :comment, :status

  has_one :user, through: :address
  belongs_to :restaurant
  belongs_to :address
  accepts_nested_attributes_for :address

  has_many :line_items, dependent: :destroy

  #validates :user, presence: true
  validates :address, presence: true

  STATUSES = {pending: 'pending', accepted: 'accepted', rejected: 'rejected'}

  PAYMENT_STATUSES = ['pending', 'paid_cash', 'paid_online']

  validates_inclusion_of :status, :in => STATUSES.values,
          :message => "{{value}} must be in #{STATUSES.values.join ', '}"

  scope :pending, where(status: STATUSES[:pending])
  scope :accepted, where(status: STATUSES[:accepted])
  scope :rejected, where(status: STATUSES[:rejected])
  

  def add_line_items_from_cart(cart)
  	cart.line_items.each do |item|
  		item.cart_id = nil
  		line_items << item
  	end
  end

  def total_price
    line_items.to_a.sum {|item| item.total_price }
  end

  def pending?
    status == STATUSES[:pending]
  end

end
