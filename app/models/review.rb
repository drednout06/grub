# == Schema Information
#
# Table name: reviews
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  restaurant_id :integer
#  content       :text
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  title         :string(255)
#

class Review < ActiveRecord::Base
  attr_accessible :content, :restaurant_id, :user_id, :user, :title

  belongs_to :restaurant
  belongs_to :user

  validates :user_id, presence: true
  validates :restaurant_id, presence: true
  validates :content, presence: true
  validates :title, presence: true
end
