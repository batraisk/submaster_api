module Statistics
  class Page

    attr_reader :page

    def initialize(page, params = {})
      @page = page
      @params = params
      @from = DateTime.now.beginning_of_day
      @to = DateTime.now.end_of_day
      set_range if params[:mode]
    end

    def set_range
      date = DateTime.parse(@params[:date])
      case @params[:mode]
      when 'date'
        @from = date.beginning_of_day
        @to = date.end_of_day
      when 'week'
        @from = date.beginning_of_week
        @to = date.end_of_week
      when 'month'
        @from = date.beginning_of_month
        @to = date.end_of_month
      when 'year'
        @from = date.beginning_of_year
        @to = date.end_of_year
      end
    end

    def full_stats
      {
        subscribers: @page.logins.where(status: 'subscribed').count,
        clicks: @page.guests.count,
        ctr: @page.guests.count > 0 ? @page.guests.where(guests: {status: 'success'}).count.to_f / @page.guests.count.to_f : 0
      }
    end

    def stats
      {
        data: {
         clicks: clicks,
         subscribers: subscribers,
         ctr: ctr
        }
      }
    end

    def clicks
      guests_scope = @page.guests.where(status: 'welcome_page').where('created_at BETWEEN ? AND ?', @from, @to)
      data = if @params[:mode] == 'date'
                 guests_scope.group_by_hour('created_at')
                   .count(:id).map { |date, count| {date: date.strftime('%T'), count: count} }
               else
                 guests_scope.group_by_day('created_at')
                   .count(:id).map { |date, count| {date: date, count: count} }
             end
      {
        data: data,
        total_count: guests_scope.count,
        trend: trend(data)
      }
    end

    def subscribers
      logins_scope = @page.logins.where(status: 'subscribed').where('created_at BETWEEN ? AND ?', @from, @to)
      data = if @params[:mode] == 'date'
               logins_scope.group_by_hour('created_at')
                 .count(:id).map { |date, count| {date: date.strftime('%T'), count: count} }
             else
               logins_scope.group_by_day('created_at')
                 .count(:id).map { |date, count| {date: date.strftime('%T'), count: count} }
             end
      {
        data: data,
        total_count: logins_scope.count,
        trend: trend(data)
      }
    end

    def ctr
      guests_scope = @page.guests.where('created_at BETWEEN ? AND ?', @from, @to)
      data = if @params[:mode] == 'date'
               guests_scope
                 .group_by_hour('created_at').group('date(created_at)', 'status')
                 .count.map {|date, count| {date: date[0].strftime('%T'), status: date[1], count: count}}
             else
               guests_scope
                 .group('date(created_at)', 'status')
                 .count.map {|date, count| {date: date[0], status: date[1], count: count}}
             end

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
      result = result.map {|date, count| {date: date, count: count.round(1)}}
      {
        data: result,
        total_count: result.last ? result.last[:count] : 0,
        trend: trend(result)
      }
    end

    def trend(data)
      return 0 if (data.count < 2) || data.first[:count].zero?
      return ((data.last[:count].to_f - data.first[:count].to_f) / data.first[:count].to_f * 100).round(1) if data.first[:count] != 0
    end

  end
end
