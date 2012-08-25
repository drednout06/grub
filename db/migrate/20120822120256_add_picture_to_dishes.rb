class AddPictureToDishes < ActiveRecord::Migration
  def self.up
    add_attachment :dishes, :picture
  end

  def self.down
    remove_attachment :dishes, :picture
  end
end
