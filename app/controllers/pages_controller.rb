class PagesController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]
around_action :switch_locale

  def switch_locale(&action)
    locale = request.env['HTTP_ACCEPT_LANGUAGE']&.slice(0,2)&.to_sym || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def show
    @page = Page.find_by_url(full_url)
    @content = @page.welcome_content
    @form_authenticity_token = form_authenticity_token
    url = params[:format] ? "#{params[:url]}.#{params[:format]}" : params[:url]
    redirect_to controller: 'pages', action: 'welcome', url: url, params: request.query_parameters and return
  end

  def welcome
    @page = Page.find_by_url(params[:url])

    unless @page.user.can_pay_for_subscription?
      redirect_to controller: 'pages', action: 'out_of_stock' and return
    end
    url = params[:format] ? "#{params[:url]}.#{params[:format]}" : params[:url]
    redirect_to controller: 'pages', action: 'out_of_stock', url: url and return if @page.status == 'inactive'
    @guest = Guest.new(page: @page,
                       status: 'welcome_page',
                       remote_ip: request.remote_ip,
                       user_agent: request.user_agent)
    unless utm_params.to_h.blank?
      utm = UtmTag.new(utm_params)
      utm.guest = @guest
      utm.page = @page
    end
    @guest.save!
    @content = @page.welcome_content
    @form_authenticity_token = form_authenticity_token
  end

  def out_of_stock
    @page = Page.find_by_url(params[:url])
  end

  def enter_login
    @page = Page.find_by_url(params[:url])
    @form_authenticity_token = form_authenticity_token
  end

  def check
    @page = Page.find_by_url(params[:url])
    @form_authenticity_token = form_authenticity_token
  end

  def run_deferred_events
    @page = Page.find_by_url(params[:url])
    @login = @page.logins.find_by_name(params[:login])
    @guest = Guest.find(params[:hashid])
    Scrapper::CHECK_INTERVALS.each do |interval|
      Instagram::CheckSubscribeWorker.perform_in(interval, @page.id, @login.id, @guest.id)
    end
    render head :no_content
  end

  def create
    @page = Page.find_by_url(params[:url])
    @login = @page.logins.find_or_initialize_by(name: params[:name])
    @login.name = params[:name]
    # Instagram::CheckSubscribeWorker
    if @login.save
      redirect_to controller: 'pages', action: 'success', link: params[:url], name: params[:url], login: @login.id
    else
    end
  end

  def success
    @page = Page.find_by_url(params[:url])
    not_found if @page.nil?
    render template: "pages/success"
  end

  def get_bonus
    @page = Page.find_by_url(params[:url])
    @login = @page.logins.find_by_name(params[:name])
    if @page.nil?
      head :not_found if @login.nil?
      return
    elsif @login.nil?
      render json: {access: false}, status: :ok
    else
      render json: {access: @login.is_subscribed, bonus: @page.download_link}, status: :ok
    end

  end

  def check_login_follow
    @page = Page.find_by_url(params[:url])
    creds = InstagramCredential.find(InstagramCredential.pluck(:id).sample)
    scrapper = Instagram::ScrapperService.new(creds.login, creds.password)
    is_follow = scrapper.user_is_follower(@page.instagram_login, params[:name])
    @login = @page.logins.find_by_name(params[:name])
    if @login.present?
      was_subscribed = @login.is_subscribed
      if is_follow and !was_subscribed
        @page.user.pay_for_subscription(@page, @login)
        @login.status = 'subscribed'
        @login.save
      end
    else
      @login = @page.logins.create({name: params[:name]})
    end
    # @login = @page.logins.find_or_initialize_by({name: params[:name]})
    #
    # was_subscribed = @login.is_subscribed
    # @login.pages << @page
    # @login.status = is_follow ? 'subscribed' : 'not_subscribed'
    # @login.save
    # if is_follow and !was_subscribed
    #   @page.user.pay_for_subscription(@page, @login)
    # end
    render json: {is_follow: is_follow}, status: :ok
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  private

    def login_params
      params.permit(:name)
    end

    def full_url
      if params[:format]
        return "#{params[:url]}.#{params[:format]}"
      end

      return params[:url]
    end

    def utm_params
      params.permit(:utm_source, :utm_medium, :utm_campaign, :utm_content)

    end
end
