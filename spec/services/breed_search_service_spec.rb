require 'rails_helper'

RSpec.describe 'Breed Search Service', type: :helper do
  describe 'Performing a valid breed search' do
    before do
      query_term = 'be'
      @search = BreedSearchService.new(query_term: query_term)
      @search.perform
    end

    it 'returns an array of search results' do
      expect(@search.results).to_not be_empty
      expect(@search.results).to be_kind_of(Array)
    end

    it 'saves results' do
      expect { @search.save }.to change{ BreedSearch.count }.by(1)
    end
  end

  describe 'Performing a breed search with no query term' do
    before do
      @search = BreedSearchService.new
    end

    it 'throws an error' do
      expect { @search.perform }.to raise_error
      expect(@search.results).to be_empty
    end
  end
end
