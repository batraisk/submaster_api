class Api::V1::StatisticsController < ApplicationController
  def index
    data = Statistics::Page.new(current_user, filter_params).full_stats
    render json: data
  end

  private

    def filter_params
      params.permit(:mode, :date)
    end
end