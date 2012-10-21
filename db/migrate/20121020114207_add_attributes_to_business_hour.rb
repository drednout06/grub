class AddAttributesToBusinessHour < ActiveRecord::Migration
  def change
    add_column :business_hours, :day, :string
    add_column :business_hours, :opening, :string
    add_column :business_hours, :closing, :string
  end
end
