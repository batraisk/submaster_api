class Api::V1::Users::PasswordsController < Devise::PasswordsController
  skip_before_action :verify_authenticity_token
  respond_to :json
end
