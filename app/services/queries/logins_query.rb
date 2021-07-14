module Queries
  class LoginsQuery

    attr_reader :scope, :params

    def initialize(sort, params = {})
      @sort = sort
      @params = params
    end

    def call(scope = Login.all)
      @scope = scope
      if @sort
        sort_params = sort.to_h.map { |key, value| "#{key} #{value}" }.join(', ')
        @scope = scope.order(sort_params)
      end
      if @params
        @scope = @scope.where('created_at BETWEEN ? AND ?', params[:from], params[:to])
      end
      @scope
    end
  end
end
