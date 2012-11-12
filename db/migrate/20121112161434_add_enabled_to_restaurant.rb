class AddEnabledToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :enabled, :boolean, default: false
  end
end
