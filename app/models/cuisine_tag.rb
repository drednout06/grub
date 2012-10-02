# == Schema Information
#
# Table name: cuisine_tags
#
#  id            :integer         not null, primary key
#  restaurant_id :integer
#  cuisine_id    :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class CuisineTag < ActiveRecord::Base
  attr_accessible :cuisine_id, :restaurant_id

  belongs_to :restaurant
  belongs_to :cuisine
end
