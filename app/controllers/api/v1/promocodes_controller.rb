class Api::V1::PromocodesController < ApplicationController
  # skip_before_action :verify_authenticity_token, :only => [:create, :check, :payment_link]

  def apply_promocode
    @promocode = Promocode.find_by_code(params[:code])
    user_promocode = UserPromocode.new({user: current_user, promocode: @promocode})
    if user_promocode.valid?
      user_promocode.save!
      render json: { promocode: @promocode }
    else
      render json: { errors: user_promocode.errors.messages }
    end
  end
end

