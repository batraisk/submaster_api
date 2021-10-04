# == Schema Information
#
# Table name: admin_managed_resources
#
#  id         :bigint           not null, primary key
#  action     :string           not null
#  class_name :string           not null
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  admin_managed_resources_index  (class_name,action,name) UNIQUE
#
require "test_helper"

class AdminManagedResourceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
