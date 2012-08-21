class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.integer :minimum_order
      t.integer :user_id

      t.timestamps
    end
  end
end
