# == Schema Information
#
# Table name: cities
#
#  id         :integer         not null, primary key
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  name       :string(255)
#

class City < ActiveRecord::Base
  attr_accessible :name
  has_many :districts
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
