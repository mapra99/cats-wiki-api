require 'rails_helper'

RSpec.describe BreedSearch, type: :model do
  describe 'validations' do
    it 'validates presence of required fields' do
      should validate_presence_of(:query_term)
    end
  end

  describe 'top searches query' do
    let!(:successful_searches_one) { create_list(:breed_search_result, 5, breed_id: 'abys') }
    let!(:successful_searches_two) { create_list(:breed_search_result, 10, breed_id: 'beng') }
    let!(:successful_searches_three) { create_list(:breed_search_result, 2, breed_id: 'aege') }
    let!(:failed_searches) { create_list(:failed_breed_search, 10) }

    before do
      @top_searches = BreedSearch.top_searches
      @top_breed_ids = @top_searches.map(&:breed_id)
    end

    it "shouldn't be empty" do
      expect(@top_searches).not_to be_empty
    end

    it 'should only consider successful searches' do
      expect(@top_breed_ids).not_to include('abob')
    end

    it 'should return the most frequent successful searches in sorted order' do
      expect(@top_breed_ids).to eq(%w[beng abys aege])
    end
  end
end
