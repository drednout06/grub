# == Schema Information
#
# Table name: cuisines
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  position   :integer
#

class Cuisine < ActiveRecord::Base
	before_save :set_position

  attr_accessible :name, :translations_attributes, :position

  has_many :cuisine_tags
  has_many :restaurants, through: :cuisine_tags, dependent: :destroy
  
  translates :name
  accepts_nested_attributes_for :translations

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # acts_as_list

  default_scope :order => 'position ASC'

  private

	  def set_position
	    self.position ||= Time.now.to_i
	  end
end
