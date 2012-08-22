class Menu < ActiveRecord::Base
  attr_accessible :name, :restaurant_id
  belongs_to :restaurant
  has_many :dishes, dependent: :destroy
end
