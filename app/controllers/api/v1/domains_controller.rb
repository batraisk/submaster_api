class Api::V1::DomainsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create, :destroy]

  def index
    @user_domains = current_user.domains
    scope = @user_domains.page(params[:page]).per(params[:page_size])
    @domains = Queries::DomainsQuery.new(sort_params).call(scope)
    render json: { data: ActiveModel::Serializer::CollectionSerializer.new(@domains, serializer: DomainSerializer),
                   total_pages: scope.total_pages,
                   total_count: scope.total_count
    }
  end

  def create
    @domain = current_user.domains.new(domain_params)
    if @domain.save
      Domains::Manager.new.connect_domain(@domain.url)
      render json: @domain, status: :ok
    else
      render json: @domain.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @domain = current_user.domains.find(params[:id])
    if @domain.present?
      Domains::Manager.new.remove_domain(@domain.url)
      @domain = @domain.destroy
      render json: { notice: t('domains.was_deleted') }, status: :ok
    end
    render json: { notice: 'not found' }, status: :not_found
  end

  private

    def sort_params
      if (params[:sort]).present?
        params.require(:sort).permit(:url, :status, :pages)
      else
        nil
      end
    end

    def domain_params
      params.permit(:url)

    end
end
