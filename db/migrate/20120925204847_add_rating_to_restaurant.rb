class AddRatingToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :rating, :decimal

    Restaurant.all.each do |restaurant|
    	restaurant.update_attributes(rating: restaurant.reputation_value_for(:rating))
    end
  end
end
