class CreateBusinessHours < ActiveRecord::Migration
  def change
    create_table :business_hours do |t|
      t.integer :restaurant_id
      t.text :schedule

      t.timestamps
    end
  end
end
