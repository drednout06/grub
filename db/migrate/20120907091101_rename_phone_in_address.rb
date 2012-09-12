class RenamePhoneInAddress < ActiveRecord::Migration
  def change
  	rename_column :addresses, :phone, :phone_number
  end
end
