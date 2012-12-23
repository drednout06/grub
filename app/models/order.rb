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
#  status        :string(255)
#  comment       :text
#

class Order < ActiveRecord::Base
  attr_accessible :address_id, :change_from, :delivery_time, :address,
                  :address_type, :address_attributes, :comment, :status, :restaurant_id,
                  :total, :deliver_now, :user_id

  belongs_to :user
  belongs_to :restaurant
  belongs_to :address
  accepts_nested_attributes_for :address

  has_many :line_items, dependent: :destroy

  #validates :user, presence: true
  validates :address_id, presence: true
  validates :restaurant_id, presence: true
  validates :delivery_time, presence: true, if: :preorder?
  validate :delivery_time_valid, if: :preorder?
  validate :restaurant_enabled
  validate :deliverable

  STATUSES = {pending: 'pending', accepted: 'accepted', rejected: 'rejected'}

  PAYMENT_STATUSES = ['pending', 'paid_cash', 'paid_online']

  validates_inclusion_of :status, :in => STATUSES.values,
          :message => "{{value}} must be in #{STATUSES.values.join ', '}"

  scope :pending, where(status: STATUSES[:pending])
  scope :accepted, where(status: STATUSES[:accepted])
  scope :rejected, where(status: STATUSES[:rejected])

  default_scope :order => 'created_at DESC'
  before_validation :set_delivery_time
  

  def add_data_from_cart(cart)
  	cart.line_items.each do |item|
  		item.cart_id = nil
  		line_items << item
  	end
    self.restaurant_id = cart.restaurant_id
    self.total = cart.total_price_to(address.district_id)
  end

  def total_price
    line_items.to_a.sum {|item| item.total_price }
  end

  def pending?
    status == STATUSES[:pending]
  end

  def preorder?
    !deliver_now
  end

  def delivery_time_valid
    unless delivery_time
      errors.add(:delivery_time, :invalid_delivery_time)
      return
    end
    unless restaurant.open_at?(delivery_time)
      errors.add(:delivery_time, :restaurant_closed)
    end
    unless (delivery_time > Time.zone.now and delivery_time <= Time.zone.now.tomorrow)
      errors.add(:delivery_time, :too_far_in_future)
    end
  end

  def restaurant_enabled
    unless restaurant.enabled?
      errors.add(:deliver_now, :restaurant_disabled)
    end
  end

  def deliverable
    unless restaurant.deliverabilities.where(district_id: address.district_id).exists?
      errors.add(:address_id, :no_delivery)
    end
  end

  def set_delivery_time
    self.delivery_time = Time.zone.now if deliver_now? or delivery_time.blank?
  end

end
