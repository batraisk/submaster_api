# == Schema Information
#
# Table name: logins
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  status     :string           default("not_subscribed"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  page_id    :bigint
#
# Indexes
#
#  index_logins_on_page_id  (page_id)
#
# Foreign Keys
#
#  fk_rails_...  (page_id => pages.id)
#
require "test_helper"

class LoginTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
