# == Schema Information
#
# Table name: business_hours
#
#  id            :integer         not null, primary key
#  restaurant_id :integer
#  schedule      :text
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  day           :string(255)
#  opening       :string(255)
#  closing       :string(255)
#

require 'spec_helper'

describe BusinessHour do
  pending "add some examples to (or delete) #{__FILE__}"
end
