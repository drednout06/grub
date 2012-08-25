class Menu < ActiveRecord::Base
  attr_accessible :name, :restaurant_id
  belongs_to :restaurant
  has_many :dishes, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :restaurant_id, presence: true
end
