class AddStatusToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :status, :string
    add_column :orders, :comment, :text
  end
end
