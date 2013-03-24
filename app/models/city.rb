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
  attr_accessible :name, :translations_attributes
  has_many :districts, dependent: :destroy
  has_many :restaurants
  has_many :addresses
  
  
  translates :name
  accepts_nested_attributes_for :translations

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def as_json(options={})
    super(only: [:id, :name], include: [districts: {only: [:id, :name]} ])
  end
end
