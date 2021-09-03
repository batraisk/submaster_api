class Api::V1::UtmTagsController < ApplicationController
  before_action :set_page

  def index
    data = Queries::UtmTagsQuery.new(nil, filters_params).call(@page.utm_tags)
    data = Kaminari.paginate_array(data).page(params[:page]).per(params[:page_size])
    render json: { data: data,
                   total_pages: data.total_pages,
                   total_count: data.total_count
    }
  end

  private

    def set_page
      @page = Page.find_by(id: params[:subscribe_page_id])
    end

    def filters_params
      if (params[:filters]).present?
        params.require(:filters).permit(:from, :to)
      else
        nil
      end
    end
end
