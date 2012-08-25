class Dish < ActiveRecord::Base
  attr_accessible :description, :menu_id, :name, :price, :picture
  belongs_to :menu
  has_one :restaurant, through: :menu
  has_many :dishes
  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "150x150>" },
  								:url  => "/assets/dishes/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/dishes/:id/:style/:basename.:extension"

  validates_attachment :picture, :presence => true,
	  content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] },
	  size: { in: 0..5.megabytes }

	validates :menu_id, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :price, presence: true
  validates_numericality_of :price, presence: true, greater_than: -1, only_integer: true

  before_destroy :ensure_not_referenced_by_any_line_item

  private
  
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end
