# == Schema Information
#
# Table name: pages
#
#  id                         :bigint           not null, primary key
#  download_link              :string
#  facebook_server_side_token :string
#  instagram_login            :string
#  layout                     :string
#  out_of_stock_description   :text
#  out_of_stock_title         :string
#  page_name                  :string
#  status                     :string           default("inactive")
#  success_button_text        :string
#  success_description        :text
#  success_title              :string
#  theme                      :string
#  timer_enable               :boolean
#  timer_text                 :string
#  timer_time                 :integer
#  url                        :string
#  welcome_button_text        :string
#  welcome_content            :text
#  welcome_description        :text
#  welcome_title              :string
#  yandex_metrika             :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  domain_id                  :bigint
#  facebook_pixel_id          :string
#  user_id                    :bigint
#
# Indexes
#
#  index_pages_on_domain_id  (domain_id)
#  index_pages_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (domain_id => domains.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class PageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
