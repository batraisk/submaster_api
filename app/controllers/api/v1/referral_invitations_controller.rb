class Api::V1::ReferralInvitationsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]

  def show
    @referral_invitation = ReferralInvitation.find_by(access_token: params[:id])
    render json: @referral_invitation
  end

  def create
    attrs = {sender: current_user, recipient_email: params[:email].downcase, bonus: current_user.invitations_bonus}
    @referral_invitation = ReferralInvitation.new(attrs)
    if @referral_invitation.save
      UserMailer.with(referral_invitation: @referral_invitation, user: current_user).referral_invite_email.deliver_later
      render json: @referral_invitation
    else
      render json: @referral_invitation.errors, status: :unprocessable_entity
    end
  end

  private

    def invitation_params
      params.permit(:email)
    end

end