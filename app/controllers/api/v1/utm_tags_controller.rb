class Api::V1::UtmTagsController < ApplicationController
  before_action :set_page

  def index
    scope = @page.utm_tags.page(params[:page]).per(params[:page_size])
    # @logins = Queries::LoginsQuery.new(sort_params, filters_params).call(scope)
    render json: { data: ActiveModel::Serializer::CollectionSerializer.new(scope, serializer: LoginSerializer),
                   total_pages: scope.total_pages,
                   total_count: scope.total_count
    }
  end

  private

    def set_page
      @page = Page.find_by(id: params[:subscribe_page_id])
    end
end
