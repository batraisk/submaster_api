# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable, :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  has_many :domains, dependent: :delete_all
  has_many :payments, dependent: :delete_all
  has_many :pages, dependent: :delete_all
  has_one :user_info
  has_many :user_promocodes
  has_many :promocodes, through: :user_promocodes
  has_many :purchases

  after_create :create_info

  def balance
    (payments.where(order_status: "approved").sum(:amount) +
      promocodes.sum(:amount) * 100 -
      purchases.sum(:amount)).to_f / 100
  end

  def can_pay_for_subscription?
    price = PaymentConfig.instance.ru_price || 0
    return false if balance < price
    true
  end

  def subscription_price
    PaymentConfig.instance.ru_price
  end

  def pay_for_subscription(page, login)
    return unless can_pay_for_subscription?
    purchases.create!({product: login, amount: subscription_price, page: page})
  end

  private

    def create_info
      self.create_user_info!
    end
end
