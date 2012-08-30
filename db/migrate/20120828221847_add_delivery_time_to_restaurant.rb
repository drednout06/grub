class AddDeliveryTimeToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :average_delivery_time, :integer
    add_column :restaurants, :description, :text
    add_column :restaurants, :delivery_fee, :integer
  end
end
