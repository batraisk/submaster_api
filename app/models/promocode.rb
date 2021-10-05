# == Schema Information
#
# Table name: promocodes
#
#  id         :bigint           not null, primary key
#  amount     :integer
#  begins_at  :datetime
#  code       :string
#  duration   :integer
#  ends_at    :datetime
#  kind       :string           default("currency"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Promocode < ApplicationRecord
  extend Enumerize
  enumerize :kind, in: [:currency, :time_period]
  has_many :user_promocodes
  has_many :users, through: :user_promocodes
  validates :code, presence: true, uniqueness: true
end
