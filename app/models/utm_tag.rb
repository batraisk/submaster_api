# == Schema Information
#
# Table name: utm_tags
#
#  id            :bigint           not null, primary key
#  campaign      :string
#  clicks        :integer
#  content       :string
#  conversion    :integer
#  medium        :string
#  source        :string
#  subscriptions :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  page_id       :bigint
#
# Indexes
#
#  index_utm_tags_on_page_id  (page_id)
#
# Foreign Keys
#
#  fk_rails_...  (page_id => pages.id)
#
class UtmTag < ApplicationRecord
  belongs_to :page
end
