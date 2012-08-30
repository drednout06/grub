class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :district
      t.string :house
      t.string :porch
      t.string :floor
      t.string :doorphone
      t.string :comment

      t.timestamps
    end
  end
end
