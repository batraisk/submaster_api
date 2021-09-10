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
class PaymentConfig < ApplicationRecord
  validates_inclusion_of :singleton_guard, :in => [0]
  def self.instance
    # there will be only one row, and its ID must be '1'
    begin
      find(1)
    rescue ActiveRecord::RecordNotFound
      # slight race condition here, but it will only happen once
      row = PaymentConfig.new
      row.singleton_guard = 0
      row.save!
      row
    end
  end
end
