# == Schema Information
#
# Table name: user_promocodes
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  promocode_id :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_user_promocodes_on_promocode_id  (promocode_id)
#  index_user_promocodes_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (promocode_id => promocodes.id)
#  fk_rails_...  (user_id => users.id)
#
class UserPromocode < ApplicationRecord
  belongs_to :user
  belongs_to :promocode

  validates :user_id, uniqueness: { scope: [:promocode_id] }
  validate :correct_date_expected, :one_used_expected

  def correct_date_expected
    return true if promocode.nil?
    errors.add(:code, 'expired') if self.promocode.ends_at < DateTime.now
    errors.add(:code, 'not yet') if self.promocode.begins_at > DateTime.now
  end

  def one_used_expected
    return true if promocode.nil?
    user_promocode = UserPromocode.where(user: user, promocode: promocode).first
    errors.add(:code, 'used') unless user_promocode.nil?
  end

end
