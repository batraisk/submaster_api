class Api::V1::ApplicationSettingsController < ApplicationController
  def show
    render json: ApplicationSetting.instance
  end
end
