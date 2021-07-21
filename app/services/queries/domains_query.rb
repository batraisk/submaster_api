module Queries
  class DomainsQuery

    attr_reader :scope, :params

    def initialize(sort)
      @sort = sort
    end

    def call(scope = Domain.all)
      @scope = scope
      if @sort
        sort_params = []
        @sort.to_h.each do |key, value|
          if key.eql?('pages')
          else
            sort_params << "#{key} #{value}"  #.join(', ')
          end
        end
        str = sort_params.join(', ')
        @scope = scope.order(str)
      else
        @scope = scope.order(created_at: :desc)
      end

      @scope
    end
  end
end
