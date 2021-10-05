class ReferralInvitationSerializer < ActiveModel::Serializer
  attributes :recipient_email, :status, :access_token
end