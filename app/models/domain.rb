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
class Domain < ApplicationRecord
  require 'socket'
  belongs_to :user
  has_many :pages
  validates :url, presence: true, uniqueness: true
  validate :connect_expected, on: :create
  before_create :set_def_status

  def set_def_status
    self.status = 'pending'
  end

  def connect_expected
    begin
      return true if IPSocket::getaddress(url) == '18.190.83.26'
      errors.add(:url, 'wrong_ip')
    rescue Exception => e
      errors.add(:url, 'wrong_ip')
    end


  end
end
