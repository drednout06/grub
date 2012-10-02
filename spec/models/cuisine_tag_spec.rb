# == Schema Information
#
# Table name: cuisine_tags
#
#  id            :integer         not null, primary key
#  restaurant_id :integer
#  cuisine_id    :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'spec_helper'

describe CuisineTag do
  pending "add some examples to (or delete) #{__FILE__}"
end
