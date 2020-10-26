class BreedSearchService
  attr_accessor :query_term, :results

  def initialize(query_term: nil)
    @query_term = query_term
    @results = []
  end

  def perform
    raise ArgumentError unless query_term.present?

    adapter = CatsAPIAdapter.new
    @results = adapter.get(path: '/breeds/search', params: {q: @query_term})
  end
end
