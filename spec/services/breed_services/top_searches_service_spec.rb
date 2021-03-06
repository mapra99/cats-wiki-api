require 'rails_helper'

RSpec.describe 'Breed Top Searches Service', type: :helper do
  describe 'Querying top searches' do
    let!(:successful_searches_one) { create_list(:breed_search_result, 5, breed_id: 'abys') }
    let!(:successful_searches_two) { create_list(:breed_search_result, 10, breed_id: 'beng') }
    let!(:successful_searches_three) { create_list(:breed_search_result, 2, breed_id: 'aege') }
    let!(:failed_searches) { create_list(:failed_breed_search, 10) }

    let!(:top_breeds) { BreedServices::TopSearchesService.new(limit: 3).perform }

    it 'returns an array of top searches' do
      expect(top_breeds).to_not be_empty
      expect(top_breeds).to be_kind_of(Array)
    end

    it 'returns at most the amount of results specified' do
      expect(top_breeds.length).to be <= 3
    end

    it 'returns the most searched breeds in descending order' do
      expect(top_breeds.pluck('id')).to eq(%w[beng abys aege])
    end

    it 'returns 1 image per breed' do
      expect(top_breeds.pluck(:images)).not_to be_empty
      expect(top_breeds.pluck(:images)).to be_kind_of(Array)
      expect(top_breeds.pluck(:images)[0]).to be_kind_of(Array)
      expect(top_breeds.pluck(:images)[0][0]).to be_kind_of(String)
    end
  end
end
