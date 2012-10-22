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
                  :average_delivery_time, :delivery_fee, :description, :user_id,
                  :deliverabilities_attributes, :cuisines, :cuisine_ids, :rating,

                  :city_id, :crop_x, :crop_y, :crop_w, :crop_h


  has_attached_file :logo, :styles => { :large => "600x600>",
                      thumb: {geometry: "300x200>", :processors => [:cropper]}},
                      #path: "/restaurants/:attachment/:id/:style.:extension",
                      storage: :s3,
                      s3_credentials: "#{Rails.root}/config/s3.yml"
                  
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  belongs_to :city
  has_many :menus, dependent: :destroy
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

  validates :title, presence: true
  validates :average_delivery_time, presence: true
  validates :delivery_fee, presence: true
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
    business_hours.any? { |hour| hour.schedule.occurring_at?(Time.now) }
  end

  def business_hour
    business_hours.detect { |hour| hour.schedule.occurring_at?(Time.now) }
  end

  def today_hours
    business_hours.find_all { |hour| hour.day == Date::DAYNAMES[Time.now.wday].downcase }
  end

end
