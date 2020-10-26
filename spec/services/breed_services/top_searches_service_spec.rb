require 'rails_helper'

RSpec.describe 'Breed Top Searches Service', type: :helper do
  describe 'Querying top searches' do
    let!(:successful_searches_one) { create_list(:sucessful_breed_search, 5, breed_id: 'abys') }
    let!(:successful_searches_two) { create_list(:sucessful_breed_search, 10, breed_id: 'beng') }
    let!(:successful_searches_three) { create_list(:sucessful_breed_search, 2, breed_id: 'aege') }
    let!(:failed_searches) { create_list(:failed_breed_search, 10, breed_id: 'abob') }

    let!(:top_breeds) { BreedServices::TopSearchesService.new.perform(limit: 3) }

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
  end
end
