class ApiConversions::PixelWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(page_id, guest_id, message)
    page = Page.find(page_id)
    guest = Guest.find(guest_id)
    Facebook::Pixel.new(page, guest, message).call
  end
end
