require 'spec_helper'

describe LineItem do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: line_items
#
#  id         :integer         not null, primary key
#  dish_id    :integer
#  cart_id    :integer
#  quantity   :integer         default(1)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  order_id   :integer
#

