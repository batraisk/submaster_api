# == Schema Information
#
# Table name: user_promocodes
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  promocode_id :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_user_promocodes_on_promocode_id  (promocode_id)
#  index_user_promocodes_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (promocode_id => promocodes.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class UserPromocodeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
