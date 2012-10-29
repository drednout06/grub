require 'spec_helper'

describe Dish do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: dishes
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  menu_id              :integer
#  description          :text
#  price                :integer
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  position             :integer
#

