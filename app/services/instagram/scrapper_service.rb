require 'rubygems'
require 'mechanize'

class Instagram::ScrapperService
  def initialize(username = 'batraisk', password = '18052005zigad!')
    @username = username
    @password = password
    @agent = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
      # agent.user_agent_alias = Scrapper::STORIES_UA
    }
    prepare
    @agent
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

  def prepare
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
    cookie = @agent.cookie_jar.load("#{@username}_cookies") rescue false
    unless cookie
      byebug
      login_data = {'username': @username, 'password': @password}
      page = @agent.post(Scrapper::LOGIN_URL, login_data, headers)
      authenticated = JSON.parse(page.body)["authenticated"]
      authenticate_with_login unless authenticated
      @agent.cookie_jar.save_as "#{@username}_cookies", :session => true, :format => :yaml
    end
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
    page = @agent.post(Scrapper::LOGIN_URL, login_data, headers)
    authenticated = JSON.parse(page.body)["authenticated"]
    return false unless authenticated
    @agent.cookie_jar.save_as "#{@username}_cookies", :session => true, :format => :yaml
  end

  def get_user_info(username)
    user_info = @agent.get("https://www.instagram.com/#{username}/?__a=1")

    JSON.parse(user_info.body)
  end

  def get_user_id(username)
    user_info = get_user_info(username)
    user_info['graphql']['user']['id']
  end

  def get_user_followers(id, max_id = nil)
    params = {count: 10000, search_surface: 'follow_list_page'}
    params[:max_id] = max_id if max_id.present?
    # id = get_user_id(username)
    puts params
    request = @agent.get("https://i.instagram.com/api/v1/friendships/#{id}/followers", params)
    JSON.parse(request.body)
  end

  def user_is_follower(username, follower)
    id = get_user_id(username)
    return find_user_in_followers(username, follower, id)
    # body = get_user_followers(username)
    # users = body['users'].map { |t| t['username']}
    # if users.include?(follower)
    #   return true
    # elsif body['next_max_id'].present?
    #   find_user_in_followers(username, follower)
    # end
    # return false
  end

  def find_user_in_followers(username, follower, id, max_id = nil)
    body = get_user_followers(id, max_id)
    # byebug
    users = body['users'].map { |t| t['username']}
    if users.include?(follower)
      return true
    elsif body['next_max_id'].present?
      find_user_in_followers(username, follower, id, body['next_max_id'])
    end
    return false
  end
end