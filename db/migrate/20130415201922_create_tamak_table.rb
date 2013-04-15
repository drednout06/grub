class CreateTamakTable < ActiveRecord::Migration
  def change
  	Apartment::Database.create('tamak')
  end
end
