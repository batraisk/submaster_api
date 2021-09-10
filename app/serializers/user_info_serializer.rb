class UserInfoSerializer < ActiveModel::Serializer
  attributes :locale, :balance

  def balance
    object.user.balance
  end
end