class AddRestaurantToCart < ActiveRecord::Migration
  def change
    add_column :carts, :restaurant_id, :integer
  end
end
