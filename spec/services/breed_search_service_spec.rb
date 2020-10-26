require 'rails_helper'

RSpec.describe 'Breed Search Service', type: :helper do
  describe 'Performing a valid breed search' do
    before {
      query_term = 'be'
      @search = BreedSearchService.new(query_term: query_term)
      @search.perform
    }

    it 'returns an array of search results' do
      expect(@search.results).to_not be_empty
      expect(@search.results).to be_kind_of(Array)
    end

    it 'saves results' do
      expect{@search.save}.to change(BreedSearch.count).by(1)
    end
  end

  describe 'Performing a breed search with no query term' do
    before do
      @search = BreedSearchService.new
      @search.perform
    end

    it 'throws an error' do
      expect{@search.perform}.to raise_error
      expect{@searc.results}.to be_empty
    end
  end
end
