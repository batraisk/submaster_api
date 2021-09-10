module Queries
  class PaymentsQuery

    attr_reader :scope, :sort

    def initialize(sort)
      @sort = sort
    end

    def call(scope = Payment.all)
      @scope = scope
      if @sort
        sort_params = @sort.to_h.map { |key, value| "#{key} #{value}" }.join(', ')
        @scope = scope.order(sort_params)
      else
        @scope = @scope.order(created_at: :desc)
      end

      @scope
    end
  end
end
