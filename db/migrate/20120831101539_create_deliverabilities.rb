class CreateDeliverabilities < ActiveRecord::Migration
  def change
    create_table :deliverabilities do |t|
      t.integer :restaurant_id
      t.integer :district_id
      t.integer :fee

      t.timestamps
    end
  end
end
