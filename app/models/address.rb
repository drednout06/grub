class Address < ActiveRecord::Base
  attr_accessible :city, :comment, :district, :doorphone, :floor,
    :house, :porch, :address, :street, :korpus, :phone, :first_name,
    :last_name, :name

  belongs_to :user
  has_many :orders

  validates :city, presence: true
  validates :district, presence: true
  validates :phone, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :user_id, presence: true
  validates :house, presence: true
  validates :phone, presence: true
  validates :street, presence: true
end
# == Schema Information
#
# Table name: addresses
#
#  id         :integer         not null, primary key
#  city       :string(255)
#  district   :string(255)
#  house      :string(255)
#  porch      :string(255)
#  floor      :string(255)
#  doorphone  :string(255)
#  comment    :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer
#  name       :string(255)
#  first_name :string(255)
#  last_name  :string(255)
#  korpus     :string(255)
#  phone      :string(255)
#  street     :string(255)
#

