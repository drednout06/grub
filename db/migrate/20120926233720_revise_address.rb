class ReviseAddress < ActiveRecord::Migration
  def up
  	remove_column :addresses, :city
  	remove_column :addresses, :district

  	add_column :addresses, :city_id, :integer
  	add_column :addresses, :district_id, :integer
  end

  def down
  end
end
