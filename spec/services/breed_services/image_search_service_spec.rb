require 'rails_helper'

RSpec.describe 'Breed Image Search Service', type: :helper do
  describe 'Searching images for a specific breed' do
    before do
      @search = BreedServices::ImageSearchService.new(breed_id: 'beng', limit: 5)
      @search.perform
    end

    it 'returns an array of 5 cat image urls' do
      expect(@search.results).to_not be_empty
      expect(@search.results).to be_kind_of(Array)
      expect(@search.results.length).to eq(5)
      expect(@search.results[0]).to be_kind_of(String)
    end
  end

  describe 'Searching for random images' do
    before do
      @search = BreedServices::ImageSearchService.new(limit: 5)
      @search.perform
    end

    it 'returns an array of 5 cat image urls' do
      expect(@search.results).to_not be_empty
      expect(@search.results).to be_kind_of(Array)
      expect(@search.results.length).to eq(5)
      expect(@search.results[0]).to be_kind_of(String)
    end
  end
end
