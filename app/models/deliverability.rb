# == Schema Information
#
# Table name: deliverabilities
#
#  id            :integer         not null, primary key
#  restaurant_id :integer
#  district_id   :integer
#  fee           :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class Deliverability < ActiveRecord::Base
  attr_accessible :district_id, :fee, :restaurant_id
  belongs_to :district
  belongs_to :restaurant

  accepts_nested_attributes_for :district, :restaurant
end
