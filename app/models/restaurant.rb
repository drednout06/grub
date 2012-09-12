class Restaurant < ActiveRecord::Base
  attr_accessible :address, :minimum_order, :name, :logo, :title,
                  :average_delivery_time, :delivery_fee, :description, :user_id,
                  :deliverabilities_attributes, :city_id

  has_attached_file :logo, :styles => { :medium => "400x400>", :thumb => "200x200>" },
  								:url  => "/assets/restaurants/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/restaurants/:id/:style/:basename.:extension"


  belongs_to :user
  belongs_to :city
  has_many :menus, dependent: :destroy
  has_many :dishes, through: :menus
  has_many :orders
  has_many :deliverabilities, dependent: :destroy
  has_many :districts, through: :deliverabilities

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
end
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
#

