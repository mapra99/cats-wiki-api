class BreedSearchService
  attr_accessor :query_term

  def initialize(query_term: nil)
    @query_term = query_term
  end
end
