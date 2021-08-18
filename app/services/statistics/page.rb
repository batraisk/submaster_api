module Statistics
  class Page

    attr_reader :page, :params, :scope

    def initialize(user, params = {})
      @user = user
      @params = params
      @from = DateTime.new.beginning_of_day
      @to = DateTime.new.end_of_day
      @scope = user.pages.joins(:logins)
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
      # logins_scope = @scope

      logins_scope = @scope.where('logins.created_at BETWEEN ? AND ?', @from, @to)
      data = logins_scope.group('date(logins.created_at)').count(:id).map { |date, count| {date: date, count: count} }
      {
        data: data,
        total_count: logins_scope.count,
        trend: trend(data)

      }
    end

    def clicks
      data = [{:date => "Tue, 03 Aug 2021", :count => 3},
             {:date => "Fri, 06 Aug 2021", :count => 2},
             {:date => "Tue, 10 Aug 2021", :count => 5}]
      {
        data: data,
        total_count: 4434,
        trend: trend(data)
      }
    end

    def ctr
      data = [{:date => "Tue, 03 Aug 2021", :count => 3},
             {:date => "Fri, 06 Aug 2021", :count => 2},
             {:date => "Tue, 10 Aug 2021", :count => 6},
             {:date => "Tue, 11 Aug 2021", :count => 10},
             {:date => "Tue, 13 Aug 2021", :count => 1}]
      {
        data: data,
        total_count: 3400,
        trend: trend(data)
      }
    end

    def trend(data)
      return 0 if (data.count < 2)
      return ((data.last[:count].to_f - data.first[:count].to_f) / data.first[:count].to_f * 100).round(1) if data.first[:count] != 0
    end
  end
end