class Dish < ActiveRecord::Base
  attr_accessible :description, :menu_id, :name, :price
  belongs_to :menu
end
