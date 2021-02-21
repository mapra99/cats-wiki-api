module BreedServices
  class SearchService
    attr_accessor :query_term, :images_limit
    attr_reader :results

    SEARCH_BY_OPTIONS = %i[
      breed_name
      breed_id
    ].freeze

    def initialize(query_term: nil, images_limit: 1, search_by: SEARCH_BY_OPTIONS.first)
      @query_term = query_term
      @images_limit = images_limit

      raise ArgumentError unless SEARCH_BY_OPTIONS.include?(search_by)

      @search_by = search_by
    end

    def perform
      fetch_cached
      return if @results.present?

      fetch_breed_data
      fetch_image_data
      save_cached
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
      raise ArgumentError unless @query_term.present? && @search_by.present?

      case @search_by
      when :breed_name
        fetch_by_name
      when :breed_id
        fetch_by_id
      end
    end

    def fetch_by_name
      adapter = CatsAPIAdapter.new
      adapter.get(path: '/breeds/search', params: { q: @query_term })
      @results = adapter.payload
    end

    def fetch_by_id
      adapter = CatsAPIAdapter.new
      adapter.get(path: '/images/search', params: { breed_id: @query_term })

      @results = adapter.payload.present? ? adapter.payload.first['breeds'] : []
    end

    def fetch_image_data
      return unless @images_limit

      @results.map! do |breed|
        image_search = ImageSearchService.new(breed_id: breed['id'], limit: @images_limit)
        image_search.perform
        breed.merge(images: image_search.results)
      end
    end

    def passes_cache_criteria?
      @images_limit >= 10
    end

    def save_cached
      return if !passes_cache_criteria? || @results.blank?

      Rails.cache.write("breeds/search/#{@search_by}/#{@query_term}/#{@images_limit}", @results, expires_in: 1.month)
    end

    def fetch_cached
      return if !passes_cache_criteria?

      @results = Rails.cache.read("breeds/search/#{@search_by}/#{@query_term}/#{@images_limit}")
    end
  end
end
