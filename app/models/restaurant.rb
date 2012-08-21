class Restaurant < ActiveRecord::Base
  attr_accessible :address, :minimum_order, :name, :user_id
end
