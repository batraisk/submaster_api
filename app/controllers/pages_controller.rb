class PagesController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]

  def show

    @page = Page.find_by_url(full_url)
    @content = @page.welcome_content
    @form_authenticity_token = form_authenticity_token
    redirect_to controller: 'pages', action: 'welcome', url: "#{params[:url]}.#{params[:format]}"
  end

  def welcome
    @page = Page.find_by_url(params[:url])
    # @welcome_content = Pages::CreatePageService.new(@page).call
    # @page = Page.find_by_url(params[:url])
    # @content = @page.welcome_content
    @form_authenticity_token = form_authenticity_token
  end

  def enter_login
    # byebug
    @page = Page.find_by_url(params[:url])
    # @welcome_content = Pages::CreatePageService.new(@page).call
    # @page = Page.find_by_url(params[:url])
    # @content = @page.welcome_content
    @form_authenticity_token = form_authenticity_token
  end

  def check
    # byebug
    @page = Page.find_by_url(params[:url])
    # @welcome_content = Pages::CreatePageService.new(@page).call
    # @page = Page.find_by_url(params[:url])
    # @content = @page.welcome_content
    @form_authenticity_token = form_authenticity_token
  end

  def create
    @login = Login.new
    @login.name = params[:name]
    # Instagram::CheckSubscribeWorker
    if @login.save
      redirect_to controller: 'pages', action: 'success', link: params[:link], name: params[:link], login: @login.id
    else
    end
  end

  def success
    @page = Page.find_by_link(params[:link])
    render template: "pages/success"
  end

  def check_login_follow
    @page = Page.find_by_url(params[:url])
    scrapper = Instagram::ScrapperService.new('batraisk', '18052005ziga!')
    scrapper.authenticate_with_login
    is_follow = scrapper.find_user_in_followers(@page.instagram_login, params[:name])
    render json: {is_follow: is_follow}, status: :ok
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
