class Menu < ActiveRecord::Base
	before_save :set_position

  attr_accessible :name, :position
  belongs_to :restaurant
  has_many :dishes, dependent: :destroy
  delegate :owner, to: :restaurant, allow_nil: true

  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :restaurant_id }
  validates :restaurant_id, presence: true

  # acts_as_list scope: :restaurant

  default_scope :order => 'position ASC'

  private

	  def set_position
	    self.position ||= Time.now.to_i
	  end
end
# == Schema Information
#
# Table name: menus
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  restaurant_id :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

