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
  validate :delivery_time_valid, if: :preorder?, on: :create
  validate :restaurant_enabled, on: :create
  validate :deliverable, on: :create

  STATUSES = {pending: 'pending', accepted: 'accepted', rejected: 'rejected'}

  PAYMENT_STATUSES = ['pending', 'paid_cash', 'paid_online']

  validates_inclusion_of :status, :in => STATUSES.values,
          :message => "{{value}} must be in #{STATUSES.values.join ', '}"

  scope :pending, where(status: STATUSES[:pending])
  scope :accepted, where(status: STATUSES[:accepted])
  scope :rejected, where(status: STATUSES[:rejected])

  default_scope :order => 'created_at DESC'
  before_validation :set_delivery_time
  after_create :send_text_message
  

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

  def send_text_message
    number_to_send_to = restaurant.sms_phone
 
    twilio_sid = "ACf68a562909aca13dece78e60eba4eb3f"
    twilio_token = "7630418bcdf034cc1d5bf2cd07a0dfe3"
    twilio_phone_number = "4157499797"
 
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    
    body = to_s
    part_length = 140.0
    parts_count = (body.length / part_length).ceil
    begin
      parts_count.times do |i|
        part = "(#{(i+1)}/#{parts_count}) Zakaz #{id}:\n"
        part += body[i * part_length..((i+1) * part_length - 1)]
        part += ".." if i < parts_count - 1
        @twilio_client.account.sms.messages.create(
          :from => "+1#{twilio_phone_number}",
          :to => number_to_send_to,
          :body => part
        )
      end
    rescue => e
      Rails.logger.debug "Twilio error"
      Rails.logger.debug e.message
      Rails.logger.debug e.backtrace
    end
  end

  def to_s
    text = line_items.map {|li| "#{li.dish.name.strip}=#{li.quantity}" }.join("\n")
    text += "\nDostavka= #{restaurant.try(:delivery_fee, address.district_id)}\n"
    text += "Vsego: #{total}\n"

    text += address.to_s

    text += "Predzakaz: #{I18n.l(delivery_time, format: :short)}\n" unless deliver_now
    text += (change_from.nil? or change_from.zero?) ? "" : "Sdacha s: #{change_from}."

    # refactor
    locale = I18n.locale
    I18n.locale = :all
    text = I18n.transliterate text
    I18n.locale = locale
    text
  end

end
