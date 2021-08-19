class PagesController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]

  def show
    @page = Page.find_by_url(full_url)
    @content = @page.welcome_content
    @form_authenticity_token = form_authenticity_token
    url = params[:format] ? "#{params[:url]}.#{params[:format]}" : params[:url]
    redirect_to controller: 'pages', action: 'welcome', url: url
  end

  def welcome
    @page = Page.find_by_url(params[:url])
    @guest = Guest.create(page: @page, status: 'welcome_page')
    @content = @page.welcome_content
    @form_authenticity_token = form_authenticity_token
  end

  def enter_login
    @page = Page.find_by_url(params[:url])
    @form_authenticity_token = form_authenticity_token
  end

  def check
    @page = Page.find_by_url(params[:url])
    @form_authenticity_token = form_authenticity_token
  end

  def create
    @login = Login.new
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
    @login = @page.logins.find_or_initialize_by({name: params[:name]})
    @login.pages << @page
    @login.status = is_follow ? 'subscribed' : 'not_subscribed'
    @login.save
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
end
