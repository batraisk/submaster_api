class ApplicationController < ActionController::Base

  def render_json_response(resource)
    if resource.errors.empty?
      render json: resource
    else
      render json: resource.errors, status: :bad_request
    end
  end
end
