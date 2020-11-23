require 'rails_helper'

RSpec.describe 'Breed Search Service', type: :helper do
  describe 'Searching by breed name' do
    describe 'Performing a valid breed search' do
      before do
        query_term = 'be'
        @search = BreedServices::SearchService.new(query_term: query_term)
        @search.perform
      end
  
      it 'returns an array of search results' do
        expect(@search.results).to_not be_empty
        expect(@search.results).to be_kind_of(Array)
      end
  
      it 'returns by default 1 cat image per search result' do
        expect(@search.results[0]).to have_key(:images)
      end
  
      it 'saves results' do
        expect { @search.save_search }.to change{ BreedSearch.count }.by(1)
      end
    end
  
    describe 'Performing a breed search with no query term' do
      before do
        @search = BreedServices::SearchService.new
      end
  
      it 'throws an error' do
        expect { @search.perform }.to raise_error
        expect(@search.results).to be_empty
      end
    end
  
    describe 'Images involved in a breed search' do
      before do
        @search = BreedServices::SearchService.new(query_term: 'be', include_images: 5)
        @search.perform
      end
  
      it 'returns 5 images per search result' do
        expect(@search.results[0]).to have_key(:images)
        expect(@search.results.pluck(:images)).not_to be_empty
        expect(@search.results.pluck(:images)).to be_kind_of(Array)
        expect(@search.results.pluck(:images)[0]).to be_kind_of(Array)
        expect(@search.results.pluck(:images)[0][0]).to be_kind_of(String)
      end
    end
  end

  describe 'Searching by breed id' do
    xit 'should return info about a specific breed' do
    end
  end
end
