# == Schema Information
#
# Table name: domains
#
#  id         :bigint           not null, primary key
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
class Domain < ApplicationRecord
  belongs_to :user
  has_many :pages
  validates :url, presence: true, uniqueness: true
  before_create :set_def_status

  def set_def_status
    self.status = 'pending'
  end
end
