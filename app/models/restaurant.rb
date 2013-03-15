# encoding: utf-8
# == Schema Information
#
# Table name: restaurants
#
#  id                    :integer         not null, primary key
#  name                  :string(255)
#  address               :string(255)
#  minimum_order         :integer
#  user_id               :integer
#  created_at            :datetime        not null
#  updated_at            :datetime        not null
#  logo_file_name        :string(255)
#  logo_content_type     :string(255)
#  logo_file_size        :integer
#  logo_updated_at       :datetime
#  title                 :string(255)
#  average_delivery_time :integer
#  description           :text
#  delivery_fee          :integer
#  city_id               :integer
#  rating                :decimal(, )
#

class Restaurant < ActiveRecord::Base
  attr_accessible :address, :minimum_order, :name, :logo, :title,
                  :average_delivery_time, :description, :user_id, :op_enabled,
                  :deliverabilities_attributes, :cuisines, :cuisine_ids, :rating, :enabled,
                  :sms_phone, :support_phone,
                  :city_id, :crop_x, :crop_y, :crop_w, :crop_h


  has_attached_file :logo, :styles => { :large => "600x600>",
                      thumb: {geometry: "300x200>", :processors => [:cropper]}},
                      #path: "/restaurants/:attachment/:id/:style.:extension",
                      storage: :s3,
                      s3_credentials: "#{Rails.root}/config/s3.yml"
                  
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  belongs_to :city
  has_many :menus, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :dishes, through: :menus
  has_many :orders
  has_many :deliverabilities, dependent: :destroy
  has_many :districts, through: :deliverabilities
  has_many :reviews, dependent: :destroy
  has_many :cuisine_tags, dependent: :destroy
  has_many :cuisines, through: :cuisine_tags
  has_many :evaluations, class_name: "RSEvaluation", as: :target
  has_many :user_favorites, dependent: :destroy
  has_many :fans, through: :user_favorites, source: :user
  has_many :business_hours, dependent: :destroy

  has_reputation :rating, source: :user, aggregated_by: :average
  is_impressionable

  validates :title, presence: true
  validates :average_delivery_time, presence: true
  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :address, presence: true
  validates :minimum_order, presence: true
  validates_numericality_of :minimum_order, greater_than: -1, only_integer: true
  validates_attachment :logo, :presence => true,
	  content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] },
	  size: { in: 0..5.megabytes }

  accepts_nested_attributes_for :deliverabilities

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_logo, :if => :cropping?

  default_scope :order => 'rating DESC'
  scope :enabled, where(enabled: true)

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def logo_geometry(style = :original)
    @geometry ||= {}
    logo_path = (logo.options[:storage] == :s3) ? logo.url(style) : logo.path(style)
    @geometry[style] ||= Paperclip::Geometry.from_file(logo_path)
  end
  
  def reprocess_logo
    logo.reprocess!
  end

  def open?
    business_hours.any? { |hour| hour.schedule.occurring_at?(Time.zone.now) }
  end

  def open_at?(time)
    business_hours.any? { |hour| hour.schedule.occurring_at?(time) }
  end

  def business_hour
    business_hours.detect { |hour| hour.schedule.occurring_at?(Time.zone.now) }
  end

  def today_hours
    business_hours.find_all { |hour| hour.day == Date::DAYNAMES[Time.zone.now.wday].downcase }
  end

  def delivery_fee(district_id)
    deliverabilities.find_by_district_id(district_id).try(:fee)
  end

  def views_count_by_day(start, finish = Time.zone.now)
    views = impressions.where(created_at: start.beginning_of_day..finish.end_of_day)
    views = views.group("date(created_at)")
    views = views.select("date(created_at) as created_at, count(*) as count")
    views.each_with_object({}) do |view, counts|
      counts[view.created_at.to_date] = view.count
    end
  end

  def orders_count_by_day(start, finish = Time.zone.now)
    orders = self.orders.accepted.where(created_at: start.beginning_of_day..finish.end_of_day)
    orders = orders.group("date(created_at)")
    orders = orders.select("date(created_at) as created_at, count(*) as count")
    orders.each_with_object({}) do |order, counts|
      counts[order.created_at.to_date] = order.count
    end
  end

  def revenues_by_day(start, finish = Time.zone.now)
    revenues = orders.accepted.where(created_at: start.beginning_of_day..finish.end_of_day)
    revenues = revenues.group("date(created_at)")
    revenues = revenues.select("date(created_at) as created_at, sum(total) as total_sum")
    revenues.each_with_object({}) do |revenue, sums|
      sums[revenue.created_at.to_date] = revenue.total_sum
    end
  end

  def views_count(start = Time.zone.now, finish = Time.zone.now)
    impressions.where(created_at: start.beginning_of_day..finish).count
  end

  def meta_title
    "#{title} #{name} - доставка #{cuisines.map {|c| c.name}.join(' / ')} еда"
  end

end