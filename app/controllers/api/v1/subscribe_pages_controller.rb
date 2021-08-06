class Api::V1::SubscribePagesController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create, :update, :destroy, :get_bonus]

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
    # byebug
    if @page.update(page_params)
      render json: @page, status: :ok
    else
      render json: @page.errors, status: :unprocessable_entity
    end
  end

  def create
    @page = current_user.pages.new(page_params)
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

  private

    def page_params
      params.permit(
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
        :background,
        :status
      )
    end
end
