# == Schema Information
#
# Table name: pages
#
#  id                         :bigint           not null, primary key
#  download_link              :string
#  facebook_server_side_token :string
#  insta_avatar               :string
#  instagram_login            :string
#  layout                     :string
#  out_of_stock_description   :text
#  out_of_stock_title         :string
#  page_name                  :string
#  privacy_policy             :string           default("")
#  status                     :string           default("active")
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
#  youtube                    :string
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
class PageSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :url, :background,
             :download_link, :facebook_server_side_token,
             :instagram_login, :out_of_stock_description,
             :out_of_stock_title, :page_name,
             :success_button_text, :success_description,
             :success_title, :theme, :layout, :statistics,
             :timer_enable, :timer_text, :youtube,
             :timer_time, :welcome_button_text,
             :welcome_description, :welcome_title, :insta_avatar,
             :yandex_metrika, :facebook_pixel_id, :status,
             :domain_id, :link_to_page

  def background
    return unless object.background.attached?
    rails_blob_path(object.background, only_path: true)
    # url = rails_representation_url(object.background.variant(resize_to_limit: [520, 520]), only_path: true)
    # {
    #   attachment_id: object.background.id,
    #   path: url
    # }
  end

  def link_to_page
    return "http://localhost:3000/pages/#{object.url}" if Rails.env.development?
    return "https://#{object.domain.url}/pages/#{object.url}" if object.domain.present?
    "https://submaster.pro/pages/#{object.url}"
  end

  def domain_id
    object.domain_id || 0
  end

  def statistics
    Statistics::Page.new(object).full_stats
  end
end
