# == Schema Information
#
# Table name: payments
#
#  id                :bigint           not null, primary key
#  actual_amount     :string
#  actual_currency   :string
#  amount            :integer
#  card_bin          :string
#  card_type         :string
#  currency          :string
#  fee               :string
#  masked_card       :string
#  order_status      :string           default("created"), not null
#  order_time        :datetime
#  reversal_amount   :string
#  sender_account    :string
#  sender_cell_phone :string
#  sender_email      :string
#  settlement_amount :string
#  signature         :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  order_id          :string
#  user_id           :bigint
#
# Indexes
#
#  index_payments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Payment < ApplicationRecord
  belongs_to :user
end
