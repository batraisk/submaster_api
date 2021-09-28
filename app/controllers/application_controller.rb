class ApplicationController < ActionController::Base
  # around_action :switch_locale
  before_action :check_host

  def switch_locale(&action)
    # locale = request.env['HTTP_ACCEPT_LANGUAGE']&.slice(0,2)&.to_sym || I18n.default_locale
    # if params[:controller].split("/").first.eql? 'admin'
    #   locale = :en
    # elsif current_user
    #   locale = current_user.user_info.locale&.to_sym || :en
    # end
    # I18n.with_locale(locale, &action)
  end

  def check_host
    return unless Rails.env.production?
    hostname = request.host.sub('www.', '')
    return if hostname.downcase.eql?('submaster.pro')
    domain = Domain.find_by_url(hostname)
    return if domain.present?
    render :status => 404
  end

  def render_json_response(resource)
    if resource.errors.empty?
      render json: resource
    else
      render json: resource.errors, status: :bad_request
    end
  end
end
