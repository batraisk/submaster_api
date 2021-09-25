# == Schema Information
#
# Table name: user_infos
#
#  id         :bigint           not null, primary key
#  country    :string           default("RU")
#  locale     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_user_infos_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserInfoSerializer < ActiveModel::Serializer
  attributes :locale, :balance, :country, :price

  def balance
    object.user.balance
  end

  def price
    payment_config = PaymentConfig.instance
    return (payment_config.ru_price.to_f / 100).to_f.round(2) if object.country.eql?("RU")
    (payment_config.en_price.to_f / 100).to_f.round(2)
  end
end
