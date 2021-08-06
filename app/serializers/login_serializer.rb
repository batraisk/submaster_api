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
class LoginSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :date

  def date
    object.created_at.strftime('%F')
  end
end
