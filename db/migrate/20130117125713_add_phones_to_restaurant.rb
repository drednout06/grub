class AddPhonesToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :sms_phone, :string
    add_column :restaurants, :support_phone, :string
  end
end
