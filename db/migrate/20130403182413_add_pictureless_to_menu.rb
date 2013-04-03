class AddPicturelessToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :pictureless, :boolean, default: false
  end
end
