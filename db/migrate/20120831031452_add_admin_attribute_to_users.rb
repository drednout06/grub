class AddAdminAttributeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :boolean, default: false, null: false

    User.create! do |r|
      r.email      = 'default@example.com'
      r.password   = 'password'
      r.admin = true
    end
  end

  def self.down
    remove_column :users, :admin
    User.find_by_email('default@example.com').try(:delete)
  end
end
