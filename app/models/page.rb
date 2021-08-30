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
class Page < ApplicationRecord
  belongs_to :user
  # belongs_to :domain
  before_save :generate_content
  has_one_attached :background
  has_and_belongs_to_many :logins
  has_many :utm_tags
  has_many :guests

  COLORS = {
    default: {
      primary: '#2F54EB',
      bg_color: '#D6E4FF',
      layout_color: '#FFF',
      gradient: 'linear-gradient(90deg, #2F54EB 55.12%, #ADC6FF 100%)',
      text_color: '#1F1F1F',
    },
    blue: {
      primary: '#08979C',
      bg_color: '#BEEAEC',
      layout_color: '#F0F5FF',
      gradient: 'linear-gradient(90deg, #1890FF 55.12%, #91D5FF 100%)',
      text_color: '#1F1F1F',
    },
    pink: {
      primary: '#EB2F96',
      bg_color: '#FFD6E7',
      layout_color: '#FFF0F6',
      gradient: 'linear-gradient(90deg, #EB2F96 55.12%, #FFADD2 100%)',
      text_color: '#1F1F1F',
    },
    mustard: {
      primary: '#262626',
      bg_color: '#262626',
      layout_color: '#FFD254',
      gradient: 'linear-gradient(90deg, #262626 55.12%, #8C8C8C 100%)',
      text_color: '#1F1F1F',
    },
    dark: {
      primary: '#722ED1',
      bg_color: '#262626',
      layout_color: '#262626',
      gradient: 'linear-gradient(90deg, #722ED1 55.12%, #D3ADF7 100%)',
      text_color: '#FFF',
    },

    natural: {
      primary: '#2F54EB',
      gradient: 'linear-gradient(90deg, #2F54EB 55.12%, #ADC6FF 100%)'
    },
    gold: {
      primary: '#FA541C',
      gradient: 'linear-gradient(90deg, #FA541C 55.12%, #FFBB96 100%)'
    },
    lime: {
      primary: '#7CB305',
      gradient: 'linear-gradient(90deg, #A0D911 55.12%, #EAFF8F 100%)',
    },
    # blue: {
    #   primary: '#1890FF',
    #   gradient: 'linear-gradient(90deg, #1890FF 55.12%, #91D5FF 100%)',
    # },
    magenta: {
      primary: '#EB2F96',
      gradient: 'linear-gradient(90deg, #EB2F96 55.12%, #FFADD2 100%)',
    },
    yellow: {
      primary: '#434343',
      gradient: 'linear-gradient(90deg, #262626 55.12%, #8C8C8C 100%)',
    },
    purple: {
      primary: '#722ED1',
      gradient: 'linear-gradient(90deg, #722ED1 55.12%, #D3ADF7 100%)',
    }
  }.freeze;

  private

    def generate_content

      self.welcome_content = Pages::CreatePageService.new(self, self.layout).call
    end
end
