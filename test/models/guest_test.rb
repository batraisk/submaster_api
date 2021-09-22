# == Schema Information
#
# Table name: guests
#
#  id         :bigint           not null, primary key
#  remote_ip  :string
#  status     :string
#  user_agent :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  page_id    :bigint
#
# Indexes
#
#  index_guests_on_page_id  (page_id)
#
# Foreign Keys
#
#  fk_rails_...  (page_id => pages.id)
#
require "test_helper"

class GuestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
