class Api::V1::DomainsController < ApplicationController
  def index
    @user_domains = current_user.domains

    render json: @user_domains, status: :ok
  end
end
