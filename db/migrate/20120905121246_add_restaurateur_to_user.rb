class AddRestaurateurToUser < ActiveRecord::Migration
  def change
    add_column :users, :restaurateur, :boolean, default: false
  end
end
