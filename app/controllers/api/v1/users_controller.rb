class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: %w[show]

  def show
    render_json_response(@user)
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
