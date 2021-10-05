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
class ReferralInvitation < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User", optional: true
  before_create :generate_token
  validate :user_not_exist_expected, on: :create
  validates_format_of :recipient_email, with: Devise::email_regexp
  scope :not_confirmed, -> { where.not(status: 'confirmed' )}
  scope :confirmed, -> { where(status: 'confirmed' )}

  def accepted(recipient)
    self.update(status: 'accepted', recipient: recipient)
  end

  def confirm
    self.update(status: 'confirmed')
    ReferralInvitation.not_confirmed.where(recipient_email: self.recipient_email).destroy_all
  end

  private
    def generate_token
      self.access_token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless self.class.exists?(access_token: random_token)
      end
    end

    def user_not_exist_expected
      return if User.find_by(email: recipient_email.downcase).nil?
      errors.add(:recipient_email, I18n.t('activerecord.errors.messages.taken'))
    end
end
