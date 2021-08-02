class Api::V1::AccountsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:update]

  def update
    @user=current_user
    if params[:email].present?
      # @user.password_not_needed=true
      @user.email=params[:email]
      @user.skip_reconfirmation!
    end
    if params[:new_password].present?
      @user.errors.add('password not valid') if @user.valid_password?(params[:password])
      @user.errors.add('confirmation password does not match') if params[:password] != params[:confirm_password]
      @user.password = params[:new_password]
      @user.skip_reconfirmation!
    end
    if @user.save
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
end
