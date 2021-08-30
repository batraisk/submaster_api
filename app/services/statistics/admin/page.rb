module Statistics::Admin
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

    def clicks
      guests_scope = @page.guests.where(status: 'welcome_page')
      data = guests_scope.group_by_day('created_at').count(:id)
      {
        data: data,
        total_count: guests_scope.count,
      }
    end

    def subscribers
      logins_scope = @page.logins.where(status: 'subscribed')
      data = logins_scope.group_by_day('created_at').count(:id)
      {
        data: data,
        total_count: logins_scope.count,
      }
    end

    def ctr
      guests_scope = @page.guests
      data = guests_scope
               .group('date(created_at)', 'status')
               .count.map {|date, count| {date: date[0], status: date[1], count: count}}

      result = {}
      temp_result = {}
      data.each do |item|
        if !temp_result[item[:date]]
          temp_result[item[:date]] = item[:count]
          result[item[:date]] = 0
        else

          if item[:status] == 'welcome_page'
            result[item[:date]] = 100 * temp_result[item[:date]].to_f / (temp_result[item[:date]] + item[:count]).to_f
          else
            result[item[:date]] = 100 * item[:count].to_f / (temp_result[item[:date]] + item[:count]).to_f
          end

        end
      end
      {
        data: result,
      }
    end

    def trend(data)
      return 0 if (data.count < 2) || data.first[:count].zero?
      return ((data.last[:count].to_f - data.first[:count].to_f) / data.first[:count].to_f * 100).round(1) if data.first[:count] != 0
    end

  end
end
