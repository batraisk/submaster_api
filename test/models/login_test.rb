# == Schema Information
#
# Table name: logins
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  status     :string           default("not_subscribed"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class LoginTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
