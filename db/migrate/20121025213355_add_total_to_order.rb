class AddTotalToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :total, :integer
    add_column :orders, :deliver_now, :boolean
  end
end
