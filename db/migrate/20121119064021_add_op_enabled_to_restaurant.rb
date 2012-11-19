class AddOpEnabledToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :op_enabled, :boolean, default: :true
  end
end
