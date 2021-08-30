class Api::V1::StatisticsController < ApplicationController
  def index
    data = Statistics::Pages.new(current_user, filter_params).full_stats
    render json: data
  end

  def set_status
    @guest = Guest.find(params[:hashid])
    @guest.update({status: params[:status]}) if @guest.present?
    render json: {}, status: :ok
  end


  private

    def filter_params
      params.permit(:mode, :date)
    end
end