class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    super
    if params[:user].key?(:invite_token)
      ReferralInvitation.find_by(access_token: params[:user][:invite_token]).try(:accepted, resource)
    end

  end
end
