class Api::V1::Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    session.destroy
    warden.authenticate!(scope: :user)
    super
  end

  private

    def respond_with(resource, _opts = {})
      render_json_response(resource)
    end

    def respond_to_on_destroy
      head :ok
    end
end
