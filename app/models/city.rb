class City < ActiveRecord::Base
  attr_accessible :name
  has_many :districts
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
