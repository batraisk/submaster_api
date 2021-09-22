class Instagram::CheckSubscribeWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(page_id, login_id, guest_id)
    page = Page.find(page_id)
    guest = Guest.find(guest_id)
    login = Login.find(login_id)
    creds = InstagramCredential.find(InstagramCredential.pluck(:id).sample)
    user = page.user
    return if page.nil? or login.nil? or creds.nil? or guest.nil? or login.is_subscribed
    return unless user.can_pay_for_subscription?

    scrapper = Instagram::ScrapperService.new(creds.login, creds.password)
    is_follow = scrapper.user_is_follower(page.instagram_login, login.name)
    return unless is_follow

    login.status = 'subscribed'
    if login.save
      user.pay_for_subscription(page, login)
      Facebook::Pixel.new(page, guest).call()
    end
  end

end