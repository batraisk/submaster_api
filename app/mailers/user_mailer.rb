class UserMailer < ApplicationMailer
  default from: Rails.application.credentials[:yandex_mail][:login]

  def referral_invite_email
    @user = params[:user]
    @referral_invitation = params[:referral_invitation]
    base_url = Rails.env.production? ? "https://submaster.pro/" : "http://localhost:4200/"
    @url = "#{base_url}auth/register?referral_token=#{@referral_invitation.access_token}"
    I18n.with_locale(@user.user_info.locale&.to_sym || :ru) do
      mail(to: @referral_invitation.recipient_email, subject: I18n.t('mailer.invite_subject'))
    end
  end
end