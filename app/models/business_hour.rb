# == Schema Information
#
# Table name: business_hours
#
#  id            :integer         not null, primary key
#  restaurant_id :integer
#  schedule      :text
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  day           :string(255)
#  opening       :string(255)
#  closing       :string(255)
#

class BusinessHour < ActiveRecord::Base
	include IceCube

  attr_accessible :restaurant_id, :schedule, :day, :opening, :closing  
  serialize :schedule, Hash
  belongs_to :restaurant

  validates :restaurant_id, presence: true
  validates :schedule, presence: true
  validates :day, presence: true
  validates :opening, presence: true
  validates :closing, presence: true

  def schedule=(new_schedule)
    write_attribute(:schedule, new_schedule.to_hash)
  end

  def schedule
    Schedule.from_hash(read_attribute(:schedule))
  end

  def to_s
    "#{opening} - #{closing}"
  end
  
end
