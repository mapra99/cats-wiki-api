module BreedServices
  class ImageSearchService
    attr_reader :results

    def initialize breed_id: nil, limit: 1
      @breed_id = breed_id
      @limit = limit
    end

    def perform
      fetch_images
      extract_urls
    end

    private

    def fetch_images
      @results = [] and return if @limit.zero?

      params = {}
      params.merge!(limit: @limit)
      params.merge!(breed_id: @breed_id) if @breed_id.present?

      adapter = CatsAPIAdapter.new
      adapter.get(path: '/images/search', params: params)
      @results = adapter.payload
    end

    def extract_urls
      @results = @results.pluck('url')
    end
  end
end
