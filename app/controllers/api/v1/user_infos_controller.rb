class Api::V1::UserInfosController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:set_locale]
  def index

  end

  def show
    render json: current_user.user_info, status: :ok
  end

  def set_locale
    current_user.user_info.update({locale: params[:locale]})
    render json: current_user.user_info, status: :ok
  end
end