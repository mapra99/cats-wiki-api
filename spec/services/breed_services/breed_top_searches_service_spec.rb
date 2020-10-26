require 'rails_helper'

RSpec.describe 'Breed Top Searches Service', type: :helper do
  describe 'Querying top searches' do
    before do
      let!(search_record) { create :sucessful_breed_search }
      @search = BreedServices::TopSearchService.new
      @search.perform
    end

    it 'returns an array of top searches' do
      expect(@search.results).to_not be_empty
      expect(@search.results).to be_kind_of(Array)
    end
  end
end
