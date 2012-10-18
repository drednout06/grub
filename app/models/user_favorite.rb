class UserFavorite < ActiveRecord::Base
  attr_accessible :restaurant_id, :user_id

  belongs_to :restaurant
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :restaurant_id }
  validates :restaurant_id, presence: true
end
