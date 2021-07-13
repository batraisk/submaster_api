require 'rubygems'
require 'mechanize'

class Instagram::ScrapperService
  def initialize(username, password)
    @username = username
    @password = password
    @agent = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
      # agent.user_agent_alias = Scrapper::STORIES_UA
    }
  end

  def call
    @agent.get(Scrapper::BASE_URL) do |page|
    end
    stringio = StringIO.new
    @agent.cookie_jar.save(stringio, session: true)
    cookies = stringio.string
    @agent.cookie_jar.load StringIO.new(cookies)
    puts cookies
  end

  def authenticate_with_login
    "" "Logs in to instagram." ""
    referer = Scrapper::BASE_URL
    headers = {
      'user-agent' => Scrapper::STORIES_UA,
      'referer' => Scrapper::BASE_URL
    }
    @agent.get(Scrapper::BASE_URL, [], referer, headers)
    csrftoken = @agent.cookies[0].cookie_value.split('=')[1]
    headers['X-CSRFToken'] = csrftoken
    @agent.request_headers = headers

    login_data = {'username': @username, 'password': @password}

    @agent.post(Scrapper::LOGIN_URL, login_data, headers) do |page|
      puts page
    end
  end

  def get_user_info(username)
    user_info = @agent.get("https://www.instagram.com/#{username}/?__a=1")
    JSON.parse(user_info.body)
  end

  def get_user_id(username)
    user_info = get_user_info(username)
    user_info['graphql']['user']['id']
  end

  def get_user_followers(username, max_id = nil)
    params = {count: 10000, search_surface: 'follow_list_page'}
    params[max_id: max_id] if max_id.present?
    id = get_user_id(username)
    request = @agent.get("https://i.instagram.com/api/v1/friendships/#{id}/followers", params)
    JSON.parse(request.body)

  end

  def find_user_in_followers(username, follower)
    body = get_user_followers(username)
    users = body['users'].map { |t| t['username']}
    if users.include?(follower)
      return true
    elsif body['next_max_id'].present?
      find_user_in_followers(username, follower)
    end
    return false
  end
end