class Restaurant < ActiveRecord::Base
  attr_accessible :address, :minimum_order, :name, :user_id
  belongs_to :user

  validates :user_id, presence: true
  validates :name, presence: true
  validates :address, presence: true
  validates :minimum_order, presence: true
  validates_numericality_of :minimum_order, greater_than: -1, only_integer: true
end
