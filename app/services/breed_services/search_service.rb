module BreedServices
  class SearchService
    attr_accessor :query_term, :include_images
    attr_reader :results

    def initialize(query_term: nil, include_images: 1)
      @query_term = query_term
      @include_images = include_images
      @results = []
    end

    def perform
      fetch_breed_data
      fetch_image_data
    end

    def save_search
      search_record = BreedSearch.new(query_term: @query_term)
      return unless @results.present? && results.first['id'].present?

      search_record.breed_id = results.first['id']
      search_record.succeed = true

      search_record.save!
    end

    private

    def fetch_breed_data
      raise ArgumentError unless query_term.present?

      adapter = CatsAPIAdapter.new
      adapter.get(path: '/breeds/search', params: { q: @query_term })
      @results = adapter.payload
    end

    def fetch_image_data
      return unless @include_images
      
      @results.map! do |breed|
        image_search = ImageSearchService.new(breed_id: breed["id"], limit: @include_images)
        image_search.perform
        breed.merge(images: image_search.results)
      end
    end
  end
end
