class Api::V1::LoginsController < ApplicationController
  before_action :set_page

  def index
    scope = @page.logins.page(params[:page]).per(params[:page_size])
    @logins = Queries::LoginsQuery.new(sort_params, filters_params).call(scope)
    render json: { data: @logins,
                   total_pages: scope.total_pages,
                   total_count: scope.total_count
    }
  end

  def report
    @logins = @page.logins.order(created_at: :desc)
    response.headers[
      'Content-Disposition'
    ] = "attachment; filename=logins.xlsx"
    render "logins/report"
  end

  private
    def set_page
      @page = Page.find_by(id: params[:subscribe_page_id])
    end

    def order
      case params[:order]
      when 'name'
        "status = 'fundraising' DESC, (trend_index) DESC"
      when 'newest'
        "status = 'fundraising' DESC, created_at DESC"
      end
    end

    def login_params
      params.permit(:page, :page_size, :subscribe_page_id, sort: [:name, :created_at, :status])
    end

    def sort_params
      if (params[:sort]).present?
        params.require(:sort).permit(:name, :created_at, :status)
      else
        nil
      end
    end

    def filters_params
      if (params[:filters]).present?
        params.require(:filters).permit(:from, :to)
      else
        nil
      end
    end
end
