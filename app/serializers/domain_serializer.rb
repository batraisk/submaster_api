# == Schema Information
#
# Table name: domains
#
#  id         :bigint           not null, primary key
#  meta_tag   :string           default("")
#  status     :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_domains_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class DomainSerializer < ActiveModel::Serializer
  attributes :id, :url, :pages, :status

  def pages
    ActiveModel::Serializer::CollectionSerializer.new(object.pages, serializer: ShortPageSerializer)
  end
end
