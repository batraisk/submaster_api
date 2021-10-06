module Statistics
  class Pages

    attr_reader :page, :params, :scope

    def initialize(user, params = {})
      @user = user
      @params = params
      @from = DateTime.new.beginning_of_day
      @to = DateTime.new.end_of_day
      @scope = user.pages
      set_range if params[:mode]
    end

    def full_stats
      {
        data: {
          subscribers: subscribers,
          clicks: clicks,
          ctr: ctr
        }
      }
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

    def subscribers
      logins_scope = @scope.joins(:logins).where('logins.created_at BETWEEN ? AND ?', @from, @to).where(logins: {status: 'subscribed'})
      data = if @params[:mode] == 'date'
               logins_scope.group_by_hour('logins.created_at')
                 .count(:id).map { |date, count| {date: "#{date.strftime('%R')} - #{(date + 1.hour).strftime('%R')}", count: count} }
             else
               logins_scope.group_by_day('logins.created_at')
                 .count(:id).map { |date, count| {date: date, count: count} }
             end
      {
        data: data,
        total_count: logins_scope.count,
        trend: trend(data)

      }
    end

    def clicks
                       # .where(guests: {status: 'welcome_page'})
      guests_scope = @scope
                       .joins(:guests)
                       .where('guests.created_at BETWEEN ? AND ?', @from, @to)

      data = if @params[:mode] == 'date'
               guests_scope.group_by_hour('guests.created_at')
                 .count(:id).map { |date, count| {date: "#{date.strftime('%R')} - #{(date + 1.hour).strftime('%R')}", count: count} }
             else
               guests_scope.group_by_day('guests.created_at')
                 .count(:id).map { |date, count| {date: date, count: count} }
             end
      {
        data: data,
        total_count: guests_scope.count,
        trend: trend(data)
      }
    end

    def ctr
      guests_scope = @scope.joins(:guests).where('guests.created_at BETWEEN ? AND ?', @from, @to)
      data = if @params[:mode] == 'date'
               guests_scope
                 .group_by_hour('guests.created_at').group('guests.status')
                 .count.map {|date, count| {date: "#{date[0].strftime('%R')} - #{(date[0] + 1.hour).strftime('%R')}", status: date[1], count: count | 0}}
             else
               guests_scope
                 .group('date(guests.created_at)', 'guests.status')
                 .count.map {|date, count| {date: date[0], status: date[1], count: count}}
             end
      result = {}
      result_temp = {}
      data.each do |item|
        if !result_temp[item[:date]]
          result_temp[item[:date]] = item[:count]
          # result[item[:date]] = 0
          result[item[:date]] = item[:status] == 'welcome_page' ? 0 : 100
        else
          if item[:status] == 'welcome_page'
            result[item[:date]] = 100 * result_temp[item[:date]].to_f / (result_temp[item[:date]] + item[:count]).to_f
          else
            result[item[:date]] = 100 * item[:count].to_f / (result_temp[item[:date]] + item[:count]).to_f
          end
        end
      end
      result = result.map {|date, count| {date: date, count: count.is_a?(Numeric) ? count.round(1) : 0}}
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