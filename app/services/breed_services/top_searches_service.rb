module BreedServices
  class TopSearchesService
    attr_reader :top_breeds

    def initialize limit: 10
      @limit = limit
    end

    def perform
      Rails.cache.fetch('breeds/top-searches', expires_in: 1.day) do
        fetch_top_searches
        fetch_top_breeds_info
      end.take(@limit)
    end

    private

    def fetch_top_searches
      @top_searches = BreedSearch.top_searches
    end

    def fetch_top_breeds_info
      @top_breeds = @top_searches.map do |breed|
        search = SearchService.new(query_term: breed[:breed_id], search_by: :breed_id)
        search.perform

        next unless search.results.present?

        results = search.results[0]
        results['count'] = breed[:count]

        results
      end.compact
    end
  end
end
