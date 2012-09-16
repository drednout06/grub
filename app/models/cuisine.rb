class Cuisine < ActiveRecord::Base
  attr_accessible :name, :translations_attributes
  
  translates :name
  accepts_nested_attributes_for :translations

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
