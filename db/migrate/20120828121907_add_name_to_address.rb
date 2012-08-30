class AddNameToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :first_name, :string
    add_column :addresses, :last_name, :string
    add_column :addresses, :korpus, :string
  end
end
