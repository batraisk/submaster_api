# == Schema Information
#
# Table name: logins
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  status     :string           default("not_subscribed"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  page_id    :bigint
#
# Indexes
#
#  index_logins_on_page_id  (page_id)
#
# Foreign Keys
#
#  fk_rails_...  (page_id => pages.id)
#
class LoginSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :date

  def date
    object.created_at.strftime('%F')
  end
end
