class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :address_id
      t.timestamp :delivery_time
      t.integer :change_from

      t.timestamps
    end
  end
end
