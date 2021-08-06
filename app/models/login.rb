# == Schema Information
#
# Table name: logins
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  status     :string           default("not_subscribed"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Login < ApplicationRecord
  has_and_belongs_to_many :pages

  def is_subscribed
    self.status == 'subscribed'
  end
end
