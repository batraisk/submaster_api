module Fondy
  class Client
    attr_reader :merchant_id, :password, :server_callback_url, :response_url, :current_user

    def initialize(user)

      base_url = 'http://localhost:3000'
      base_url = 'https://www.submaster.pro' if Rails.env.production? == true
      payment_config = PaymentConfig.instance
      @current_user = user
      @server_callback_url = "#{base_url}/api/v1/payments/check/"
      @response_url = "#{base_url}/api/v1/payments/check/"
      @merchant_id = payment_config.merchant_id || '1397120'
      @password = payment_config.payment_key || 'test'
    end

  # def checkout(order_id:, order_desc:, amount:, currency:, **other_params)
  def checkout(amount_cent)
    order_id = generate_order_id
    order_desc = '...'
    amount = amount_cent.to_i * 100
    currency = 'RUB'

    params = {server_callback_url: server_callback_url,
              response_url: response_url,
              merchant_id: merchant_id,
              order_id: order_id,
              order_desc: order_desc || '...',
              amount: amount,
              currency: currency}
    signature = Signature.new(params, password).build
    params[:signature] = signature
    payment = current_user.payments.build({signature: signature,
                                            amount: amount,
                                            currency: currency,
                                            order_id: order_id})
    if payment.save!
      return send_request(:post, '/api/checkout/url', params, verify_signature: false)
    end
    false
  end

  def generate_order_id
    result = ''
    characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    40.times do
      result << characters[rand(characters.length)]
    end
    "ID#{current_user.id}_#{result}"
  end

  def status(order_id)
    params = {
      merchant_id: merchant_id,
      order_id: order_id,
    }
    send_request(:post, '/api/status/order_id', params)
  end

  def capture(order_id:, amount:, currency:)
    params = {
      merchant_id: merchant_id,
      order_id: order_id,
      amount: amount,
      currency: currency,
    }
    send_request(:post, '/api/capture/order_id', params)
  end

  def reverse(order_id:, amount:, currency:, comment: nil)
    params = {
      merchant_id: merchant_id,
      order_id: order_id,
      amount: amount,
      currency: currency,
    }
    params[:comment] = comment if comment
    send_request(:post, '/api/reverse/order_id', params)
  end

  def transaction_list(order_id:)
    send_request(
      :post,
      '/api/transaction_list',
      {
        merchant_id: merchant_id,
        order_id: order_id,
      },
      verify_signature: false,
      response_class: TransactionListResponse,
      )
  end

  private

    def send_request(method, url, params, verify_signature: true, response_class: Response)
      http_response = Request.call(method, url, params)
      response = response_class.new(http_response)
      if verify_signature && response.success?
        Signature.verify(params: response.to_h, password: password)
      end

      response.to_h
    end
  end
end
