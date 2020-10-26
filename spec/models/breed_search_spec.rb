require 'rails_helper'

RSpec.describe BreedSearch, type: :model do
  describe 'validations' do
    it 'validates presence of required fields' do
      should validate_presence_of(:query_term)
    end
  end

  describe 'top searches query' do
    let!(:successful_searches_one) { create_list(:sucessful_breed_search, 5, breed_id: 'aby') }
    let!(:successful_searches_two) { create_list(:sucessful_breed_search, 10, breed_id: 'be') }
    let!(:failed_searches) { create_list(:failed_breed_search, 10, breed_id: 'ca') }

    before do
      @top_searches = BreedSearch.top_searches
      @top_breed_ids = @top_searches.pluck(:id)
    end

    it "shouldn't be empty" do
      expect(@top_searches).not_to be_empty
    end

    it 'should only consider successful searches' do
      expect(@top_breed_ids).not_to include('ca')
    end

    it 'should return the most frequent successful searches' do
      expect(@top_breed_ids).to eq(%w[be aby])
    end
  end
end
