module Queries
  class UtmTagsQuery

    attr_reader :scope, :params

    def initialize(sort = nil, params = {})
      @sort = sort
      @params = params
    end

    def call(scope = UtmTag.all)
      @scope = scope
      # if !@params.blank?
      #   @scope = @scope.where('created_at BETWEEN ? AND ?', params[:from], params[:to])
      # end
      # if @sort
      #   sort_params = @sort.to_h.map { |key, value| "#{key} #{value}" }.join(', ')
      #   @scope = scope.order(sort_params)
      # end

      all = @scope.group(:utm_source, :utm_medium, :utm_campaign, :utm_content).count.to_h
      subscribed = @scope.joins(:guest).where({guests: {status: 'success'}}).group(:utm_source, :utm_medium, :utm_campaign, :utm_content).count.to_h

      # byebug
      result = {}
      all.each do |list, count|
        temp = {
          clicks: count,
          subscriptions: 0,
          conversion: 0
        }
        result[list] = temp
        if subscribed[list].present?
          result[list][:subscriptions] = subscribed[list]
          result[list][:conversion] = ((subscribed[list].to_f / count.to_f).to_f * 100).round(1)
        end
      end
      result.map do |key, value|
        {
          utm_source: key[0],
          utm_medium: key[1],
          utm_campaign: key[2],
          utm_content: key[3],
          clicks: value[:clicks],
          subscriptions: value[:subscriptions],
          conversion: value[:conversion],
        }
      end


      # result
    end
  end
end
