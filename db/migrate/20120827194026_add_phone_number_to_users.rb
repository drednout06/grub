class AddPhoneNumberToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :phone, :string
  	add_column :users, :second_phone, :string
  	add_column :addresses, :name, :string
  end
end
