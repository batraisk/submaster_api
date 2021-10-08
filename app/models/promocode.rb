# == Schema Information
#
# Table name: promocodes
#
#  id           :bigint           not null, primary key
#  amount       :integer
#  begins_at    :datetime
#  code         :string
#  discarded_at :datetime
#  duration     :integer
#  ends_at      :datetime
#  kind         :string           default("currency"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_promocodes_on_discarded_at  (discarded_at)
#
class Promocode < ApplicationRecord
  include Discard::Model
  extend Enumerize
  enumerize :kind, in: [:currency, :time_period]
  has_many :user_promocodes, dependent: :nullify
  has_many :users, through: :user_promocodes
  validates :code, presence: true, uniqueness: true
  default_scope { where("discarded_at IS ?", nil) }

end
