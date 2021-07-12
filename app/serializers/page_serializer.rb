class PageSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :url, :background,
             :download_link, :facebook_server_side_token,
             :instagram_login, :out_of_stock_description,
             :out_of_stock_title, :page_name,
             :success_button_text, :success_description,
             :success_title, :theme,
             :timer_enable, :timer_text,
             :timer_time, :welcome_button_text,
             :welcome_description, :welcome_title,
             :yandex_metrika, :facebook_pixel_id

  def background
    return unless object.background.attached?
    rails_blob_path(object.background, only_path: true)
    # url = rails_representation_url(object.background.variant(resize_to_limit: [520, 520]), only_path: true)
    # {
    #   attachment_id: object.background.id,
    #   path: url
    # }
  end
end