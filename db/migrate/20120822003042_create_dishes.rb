class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.integer :menu_id
      t.text :description
      t.integer :price

      t.timestamps
    end
  end
end
