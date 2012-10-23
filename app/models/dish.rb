class Dish < ActiveRecord::Base
  attr_accessible :description, :name, :price, :picture, :city_id, :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  belongs_to :menu
  has_one :restaurant, through: :menu
  has_many :line_items
  delegate :owner, to: :restaurant, allow_nil: true
  
  has_attached_file :picture, :styles => { :large => "600x600>", thumb: {geometry: "300x200>",
            processors: [:cropper]}, medium: {geometry: "450x300>", :processors => [:cropper]}},
            path: "/dishes/:attachment/:id/:style.:extension",  
            storage: :s3,
            s3_credentials: "#{Rails.root}/config/s3.yml"

  validates_attachment :picture, :presence => true,
	  content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] },
	  size: { in: 0..5.megabytes }

	validates :menu_id, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :menu_id }
  validates :description, presence: true
  validates :price, presence: true
  validates_numericality_of :price, presence: true, greater_than: -1, only_integer: true

  before_destroy :ensure_not_referenced_by_any_line_item

  acts_as_list scope: :menu

  default_scope :order => 'position ASC'

  after_update :reprocess_picture, :if => :cropping?

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def picture_geometry(style = :original)
    @geometry ||= {}
    picture_path = (picture.options[:storage] == :s3) ? picture.url(style) : picture.path(style)
    @geometry[style] ||= Paperclip::Geometry.from_file(picture_path)
  end
  
  def reprocess_picture
    picture.reprocess!
  end

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

