class Api::V1::SubscribePagesController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :create

  def index
    @user_pages = current_user.pages

    render json: @user_pages, status: :ok
  end

  def create
    # byebug
    @page = current_user.pages.new(page_params)
    if @page.save
      render json: @page, status: :ok
    else
      render json: @page.errors, status: :unprocessable_entity
    end
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
        :timer_enable,
        :timer_text,
        :timer_time,
        :url,
        :welcome_button_text,
        :welcome_description,
        :welcome_title,
        :yandex_metrika,
        :domain_id,
        :facebook_pixel_id
      )
    end
end
