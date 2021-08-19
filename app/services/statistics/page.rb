module Statistics
  class Page

    attr_reader :page

    def initialize(page)
      @page = page
    end

    def full_stats
      {
        subscribers: @page.logins.where(status: 'subscribed').count,
        clicks: @page.guests.count,
        ctr: @page.guests.count > 0 ? @page.guests.where(guests: {status: 'success'}).count.to_f / @page.guests.count.to_f : 0
      }
    end

  end
end
