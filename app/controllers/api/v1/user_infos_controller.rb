class Api::V1::UserInfosController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:set_locale]
  def index

  end

  def show
    @user_info = current_user.user_info
    location = request.location.country || "RU"
    @user_info.update({country: location}) if location != @user_info.country
    render json: @user_info, status: :ok
  end

  def set_locale
    current_user.user_info.update({locale: params[:locale]})
    render json: current_user.user_info, status: :ok
  end
end