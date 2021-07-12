# == Schema Information
#
# Table name: instagram_credentials
#
#  id         :bigint           not null, primary key
#  login      :string           not null
#  password   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class InstagramCredentialTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
