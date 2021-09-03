# == Schema Information
#
# Table name: guests
#
#  id         :bigint           not null, primary key
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  page_id    :bigint
#
# Indexes
#
#  index_guests_on_page_id  (page_id)
#
# Foreign Keys
#
#  fk_rails_...  (page_id => pages.id)
#
class Guest < ApplicationRecord
  include Hashid::Rails

  belongs_to :page
  has_one :utm_tag

end
