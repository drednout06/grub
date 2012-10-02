# == Schema Information
#
# Table name: districts
#
#  id         :integer         not null, primary key
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  name       :string(255)
#  city_id    :integer
#

class District < ActiveRecord::Base
  attr_accessible :name, :city_id, :translations_attributes
  belongs_to :city
  has_many :deliverabilities, dependent: :destroy
  has_many :addresses

  validates :city_id, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :city_id }

  translates :name
  accepts_nested_attributes_for :translations, :deliverabilities
end
