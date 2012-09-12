class Menu < ActiveRecord::Base
  attr_accessible :name
  belongs_to :restaurant
  has_many :dishes, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :restaurant_id }
  validates :restaurant_id, presence: true
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
