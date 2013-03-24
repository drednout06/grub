class RemoveDeliveryFeeFromUsers < ActiveRecord::Migration
  def change
  	remove_column :restaurants, :delivery_fee
  end
end
