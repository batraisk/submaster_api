class Pages::CreatePageService
  include Rails.application.routes.url_helpers
  attr_reader :data, :page
  def initialize(page, template_name = 'light')
    @page = page
    path = Rails.root.join('app', 'templates', template_name, 'welcome.html')
    @data = File.read(path)
  end

  def call
    %w[welcome_title
       welcome_description
       timer_text
       url
       welcome_button_text
       theme].each { |value| set_param("{{#{value}}}", page[value]) }
    unless page.background.nil?
      set_param '{{back}}', 'style="background-image: url({{image}})"'
    end
    set_youtube
    set_param('{{primary_color}}', Page::COLORS[page.theme.to_sym][:primary])
    set_param('{{gradient}}', Page::COLORS[page.theme.to_sym][:gradient])


    data
  end

  def set_youtube
    if page.youtube.present?
      iframe = "<iframe src = \"#{page.youtube}?autoplay=1\" id=\"frame-01\"
      class=\"youtube-frame\"
      title=\"YouTube video player\"
      frameborder=\"0\"
      allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\"
      allowfullscreen
      ></iframe>"
      set_param "{{youtube}}", iframe
    end
  end

  def set_param(search_tag, value)
    current_value = value || ''
    data.gsub! search_tag, current_value
  end

end