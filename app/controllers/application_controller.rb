class ApplicationController < ActionController::Base
  # around_action :switch_locale
  # before_action :check_host, :get_time_zone

  def switch_locale(&action)
    return if params[:controller].split("/").first.eql? 'admin'
    locale = request.env['HTTP_ACCEPT_LANGUAGE']&.slice(0,2)&.to_sym || I18n.default_locale
    if current_user
      locale = current_user.user_info.locale&.to_sym || :en
    end
    I18n.with_locale(locale, &action)
  end

  def get_time_zone
    time_zone = if Rails.env.test? || Rails.env.development?
                  Geocoder.search("31.23.19.197").first
                else
                  request.location
                end.data["timezone"]
    Groupdate.time_zone =  ActiveSupport::TimeZone::MAPPING.key(time_zone) || "UTC"
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
