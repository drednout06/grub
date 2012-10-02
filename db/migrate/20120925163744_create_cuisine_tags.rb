class CreateCuisineTags < ActiveRecord::Migration
  def change
    create_table :cuisine_tags do |t|
      t.integer :restaurant_id
      t.integer :cuisine_id

      t.timestamps
    end
  end
end
