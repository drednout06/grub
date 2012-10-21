class AddPositionToCuisines < ActiveRecord::Migration
  def change
    add_column :cuisines, :position, :integer
  end
end
