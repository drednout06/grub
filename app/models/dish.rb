class Dish < ActiveRecord::Base
  attr_accessible :description, :name, :price, :picture
  belongs_to :menu
  has_one :restaurant, through: :menu
  has_many :line_items
  
  has_attached_file :picture, :styles => { :medium => "400x400>", :thumb => "300x200>" },
  								:url  => "/assets/dishes/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/dishes/:id/:style/:basename.:extension"

  validates_attachment :picture, :presence => true,
	  content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] },
	  size: { in: 0..5.megabytes }

	validates :menu_id, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :menu_id }
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
# == Schema Information
#
# Table name: dishes
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  menu_id              :integer
#  description          :text
#  price                :integer
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#
