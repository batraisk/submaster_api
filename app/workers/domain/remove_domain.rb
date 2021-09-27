class Domain::RemoveDomainWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(domain_id)
    @domain = Domain.find(domain_id)
    return if @domain.nil?
    Domains::Manager.new.remove_domain(@domain.url)
  end
end
