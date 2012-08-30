class District < ActiveRecord::Base
  attr_accessible :name, :city_id, :translations_attributes
  belongs_to :city

  validates :city_id, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :city_id }

  translates :name
  accepts_nested_attributes_for :translations
end
