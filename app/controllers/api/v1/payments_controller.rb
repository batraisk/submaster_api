class Api::V1::PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create, :check, :payment_link]

  def index
    scope = current_user.payments.where.not(order_status: 'created').page(params[:page]).per(params[:page_size])
    # render json: @payments

    @payments = Queries::PaymentsQuery.new(sort_params).call(scope)
    render json: { data: ActiveModel::Serializer::CollectionSerializer.new(@payments, serializer: PaymentSerializer),
                   total_pages: scope.total_pages,
                   total_count: scope.total_count
    }
  end

  def create

    @payment = 'Fondy::Client.new()'
    render json: payment
  end

  def payment_link
    response = Fondy::Client.new(current_user).checkout(params[:amount])
    render json: {url: response[:checkout_url]}
  end

  def check
    @payment = Payment.find_by_order_id(params[:order_id])
    if @payment.present?
      @payment.update(payment_params)
    end
    url = 'http://localhost:4200/balance'
    url = 'https://www.submaster.pro/balance' if Rails.env.production? == true
    redirect_to url
  end


  private

    def payment_params
      params.permit(:amount,
                    :currency,
                    :order_id,
                    :signature,
                    :order_time,
                    :masked_card,
                    :sender_cell_phone,
                    :fee,
                    :reversal_amount,
                    :settlement_amount,
                    :actual_amount,
                    :sender_email,
                    :actual_currency,
                    :sender_account,
                    :card_type,
                    :card_bin,
                    :order_status).tap do |payment|
        payment[:order_time] = DateTime.parse(params[:order_time])
      end
    end

    def sort_params
      if (params[:sort]).present?
        params.require(:sort).permit(:order_time, :amount, :order_status)
      else
        nil
      end
    end
end

