# == Schema Information
#
# Table name: referral_invitations
#
#  id              :bigint           not null, primary key
#  access_token    :string
#  bonus           :integer
#  recipient_email :string
#  status          :string           default("created"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  recipient_id    :bigint
#  sender_id       :bigint           not null
#
# Indexes
#
#  index_referral_invitations_on_recipient_id  (recipient_id)
#  index_referral_invitations_on_sender_id     (sender_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipient_id => users.id)
#  fk_rails_...  (sender_id => users.id)
#
require "test_helper"

class ReferralInvitationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
