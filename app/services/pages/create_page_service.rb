class Pages::CreatePageService
  include Rails.application.routes.url_helpers
  attr_reader :data, :page
  def initialize(page, template_name = 'light')
    @page = page
    path = Rails.root.join('app', 'templates', template_name, 'welcome.html')
    @data = File.read(path)
  end

  def call
    byebug
    data.sub! '{{welcome_title}}', page.welcome_title
    data.sub! '{{welcome_description}}', page.welcome_description
    data.sub! '{{timer_text}}', page.timer_text if !page.timer_text.nil?
    data.sub! '{{welcome_button_text}}', page.welcome_button_text
    data.sub! '{{url}}', page.url

    data
  end

end