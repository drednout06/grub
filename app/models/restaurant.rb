class Restaurant < ActiveRecord::Base
  attr_accessible :address, :minimum_order, :name, :user_id, :logo

  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "150x150>" },
  								:url  => "/assets/restaurants/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/restaurants/:id/:style/:basename.:extension"


  belongs_to :user
  has_many :menus, dependent: :destroy
  has_many :dishes, through: :menus

  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :address, presence: true
  validates :minimum_order, presence: true
  validates_numericality_of :minimum_order, greater_than: -1, only_integer: true
  validates_attachment :logo, :presence => true,
	  content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] },
	  size: { in: 0..5.megabytes }
end
