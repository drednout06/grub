# == Schema Information
#
# Table name: reviews
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  restaurant_id :integer
#  content       :text
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  title         :string(255)
#

require 'spec_helper'

describe Review do
  pending "add some examples to (or delete) #{__FILE__}"
end
