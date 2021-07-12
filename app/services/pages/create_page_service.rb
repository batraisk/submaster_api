class Pages::CreatePageService
  attr_reader :data, :page
  def initialize(page, template_name = 'light')
    @page = page
    path = Rails.root.join('app', 'templates', template_name, 'welcome.html')
    @data = File.read(path)
  end

  def call
    data.sub! '{{welcome_title}}', page.welcome_title
    data.sub! '{{url}}', page.url
  end

end