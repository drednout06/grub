class AddAdminToTamak < ActiveRecord::Migration
	def self.up
		Apartment::Database.switch('tamak')
		User.create! do |r|
			r.first_name = 'admin'
			r.last_name = 'admin'
			r.phone_number = '995928'
			r.email      = 'team@tamak.kg'
			r.password   = 'tamak1tamak'
			r.admin = true
		end
	end

	def self.down
		User.find_by_email('team@tamak.kg').try(:delete)
	end
end
