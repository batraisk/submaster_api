# == Schema Information
#
# Table name: payment_configs
#
#  id                :bigint           not null, primary key
#  en_price          :integer
#  payment_key       :string
#  referral_bonus_en :integer          default(0)
#  referral_bonus_ru :integer          default(0)
#  ru_price          :integer
#  singleton_guard   :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  merchant_id       :string
#
# Indexes
#
#  index_payment_configs_on_singleton_guard  (singleton_guard) UNIQUE
#
require "test_helper"

class PaymentConfigTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
