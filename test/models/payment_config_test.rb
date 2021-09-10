# == Schema Information
#
# Table name: payment_configs
#
#  id              :bigint           not null, primary key
#  payment_key     :string
#  singleton_guard :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  merchant_id     :string
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
