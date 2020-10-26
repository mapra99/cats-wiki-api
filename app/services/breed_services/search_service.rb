module BreedServices
  class SearchService
    attr_accessor :query_term, :results

    def initialize(query_term: nil)
      @query_term = query_term
      @results = []
    end

    def perform
      raise ArgumentError unless query_term.present?

      adapter = CatsAPIAdapter.new
      adapter.get(path: '/breeds/search', params: { q: @query_term })
      @results = adapter.payload
    end

    def save_search
      search_record = BreedSearch.new(query_term: @query_term)
      return unless @results.present? && results.first['id'].present?

      search_record.breed_id = results.first['id']
      search_record.succeed = true

      search_record.save!
    end
  end
end
