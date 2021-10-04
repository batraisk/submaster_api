# == Schema Information
#
# Table name: admin_user_admin_roles
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  admin_role_id :integer          not null
#  admin_user_id :integer          not null
#
require "test_helper"

class AdminUserAdminRoleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
