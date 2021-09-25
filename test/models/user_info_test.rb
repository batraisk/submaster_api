# == Schema Information
#
# Table name: user_infos
#
#  id         :bigint           not null, primary key
#  country    :string           default("RU")
#  locale     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_user_infos_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class UserInfoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
