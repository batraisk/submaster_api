# == Schema Information
#
# Table name: utm_tags
#
#  id           :bigint           not null, primary key
#  utm_campaign :string
#  utm_content  :string
#  utm_medium   :string
#  utm_source   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  guest_id     :bigint
#  page_id      :bigint
#
# Indexes
#
#  index_utm_tags_on_guest_id  (guest_id)
#  index_utm_tags_on_page_id   (page_id)
#
# Foreign Keys
#
#  fk_rails_...  (guest_id => guests.id)
#  fk_rails_...  (page_id => pages.id)
#
class UtmTag < ApplicationRecord
  belongs_to :page
  belongs_to :guest
end
