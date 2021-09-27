class Domain::RemoveDomainWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(url)
    Domains::Manager.new.remove_domain(url)
  end
end
