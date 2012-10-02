class Address < ActiveRecord::Base
  attr_accessible :city, :comment, :district, :doorphone, :floor,
    :house, :porch, :address, :street, :korpus, :phone_number, :first_name,
    :last_name, :name, :orders, :user, :city_id, :district_id

  belongs_to :user
  has_many :orders
  belongs_to :city
  belongs_to :district
  accepts_nested_attributes_for :orders

  validates :city_id, presence: true
  validates :district_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :user_id, presence: true
  validates :house, presence: true
  validates :phone_number, presence: true
  validates :street, presence: true
end
# == Schema Information
#
# Table name: addresses
#
#  id           :integer         not null, primary key
#  city         :string(255)
#  district     :string(255)
#  house        :string(255)
#  porch        :string(255)
#  floor        :string(255)
#  doorphone    :string(255)
#  comment      :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  user_id      :integer
#  name         :string(255)
#  first_name   :string(255)
#  last_name    :string(255)
#  korpus       :string(255)
#  phone_number :string(255)
#  street       :string(255)
#

