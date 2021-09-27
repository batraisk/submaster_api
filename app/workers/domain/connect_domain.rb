class Domain::ConnectDomainWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(domain_id)
    @domain = Domain.find(domain_id)
    return if @domain.nil?
    begin
      Domains::Manager.new.connect_domain(@domain.url)
      @domain.update(status: 'connected')
    rescue Exception => e
      @domain.update(status: 'reject')
    end

  end
end
