module BreedServices
  class TopSearchesService
    attr_reader :top_breeds

    def initialize; end

    def perform(limit: 10)
      fetch_top_searches(limit)
      fetch_top_breeds_info
    end

    private

    def fetch_top_searches(limit)
      @top_searches = BreedSearch.top_searches.take(limit)
    end

    def fetch_top_breeds_info
      @top_breeds = @top_searches.map do |breed|
        search = SearchService.new(query_term: breed[:breed_id])
        search.perform
        results = search.results[0]
        results['count'] = breed[:count]

        results
      end
    end
  end
end
