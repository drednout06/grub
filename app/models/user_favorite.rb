# == Schema Information
#
# Table name: user_favorites
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  restaurant_id :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class UserFavorite < ActiveRecord::Base
  attr_accessible :restaurant_id, :user_id

  belongs_to :restaurant
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :restaurant_id }
  validates :restaurant_id, presence: true
end
