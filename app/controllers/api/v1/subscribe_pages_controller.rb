class Api::V1::SubscribePagesController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create, :update, :destroy]

  def index
    @user_pages = current_user.pages.order(created_at: :desc)

    render json: @user_pages, status: :ok
  end

  def show
    @user_page = current_user.pages.find(params[:id])

    render json: @user_page, status: :ok
  end

  def update
    @page = current_user.pages.find(params[:id])
    if @page.background && params[:background] == '_destroy'
      @page.background.purge
    end
    creds = InstagramCredential.find(InstagramCredential.pluck(:id).sample)
    scrapper = Instagram::ScrapperService.new(creds.login, creds.password)
    @page.insta_avatar = scrapper.get_avatar_blob(@page.instagram_login)
    if @page.update(page_params)
      render json: @page, status: :ok
    else
      render json: @page.errors, status: :unprocessable_entity
    end
  end

  def insta_info
    creds = InstagramCredential.find(InstagramCredential.pluck(:id).sample)
    scrapper = Instagram::ScrapperService.new(creds.login, creds.password)
    render json: scrapper.get_user_info(params[:nickname])
  end

  def create
    @page = current_user.pages.new(page_params)

    creds = InstagramCredential.find(InstagramCredential.pluck(:id).sample)
    scrapper = Instagram::ScrapperService.new(creds.login, creds.password)

    @page.insta_avatar = scrapper.get_avatar_blob(instagram_login)

    if @page.save
      render json: @page, status: :ok
    else
      render json: @page.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @page = current_user.pages.find(params[:id]).destroy
    render json: { notice: 'Page was deleted' }, status: :ok
  end

  def statistics
    @user_page = current_user.pages.find(params[:subscribe_page_id])
    data = Statistics::Page.new(@user_page, filter_params).stats
    render json: data, status: :ok
  end

  private

    def page_params
      attributes = [
        :download_link,
        :facebook_server_side_token,
        :instagram_login,
        :layout,
        :out_of_stock_description,
        :out_of_stock_title,
        :page_name,
        :success_button_text,
        :success_description,
        :success_title,
        :theme,
        :youtube,
        :timer_enable,
        :timer_text,
        :timer_time,
        :url,
        :welcome_button_text,
        :welcome_description,
        :welcome_title,
        :yandex_metrika,
        :domain_id,
        :facebook_pixel_id,
        :status,
        :domain_id
      ]
      return params.permit(attributes) if params[:background] == '_destroy'
      attributes << :background
      params.permit(attributes).tap do |domain|
        if domain[:domain_id]
          domain[:domain_id] = domain[:domain_id].to_s == 0.to_s ? nil : domain[:domain_id]
        end
      end
    end

    def filter_params
      params.permit(:mode, :date)
    end
end
