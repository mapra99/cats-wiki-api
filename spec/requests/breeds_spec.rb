require 'rails_helper'

RSpec.describe 'Breeds endpoints', type: :request do
  describe 'GET /breeds/search with valid query term' do
    describe 'with valid query term' do
      before do
        get '/breeds/search?term=be'
      end

      it 'should respond with an ok status' do
        payload = JSON.parse(response.body)
        expect(payload).not_to be_empty
        expect(response).to have_http_status(200)
      end

      it 'should return an array with the search matches' do
        payload = JSON.parse(response.body)
        expect(payload).not_to be_empty
        expect(payload).to be_kind_of(Array)
        expect(payload[0]).to have_key('id')
        expect(response).to have_http_status(200)
      end
    end

    describe 'with no query term' do
      before do
        get '/breeds/search?term='
      end

      it 'should respond with an ok status' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'GET /breeds/top-searches' do
    let!(:successful_searches_one) { create_list(:sucessful_breed_search, 5, breed_id: 'abys') }
    let!(:successful_searches_two) { create_list(:sucessful_breed_search, 10, breed_id: 'beng') }
    let!(:successful_searches_three) { create_list(:sucessful_breed_search, 2, breed_id: 'aege') }
    let!(:failed_searches) { create_list(:failed_breed_search, 10, breed_id: 'abob') }
    before { get '/breeds/top-searches' }

    it 'should respond with an ok status' do
      payload = JSON.parse(response.body)
      expect(payload).not_to be_empty
      expect(response).to have_http_status(200)
    end

    it 'should return as payload an array with top breeds description' do
      payload = JSON.parse(response.body)
      expect(payload).to be_kind_of(Array)
      expect(payload.pluck('id')).to eq(%w[beng abys aege])
    end
  end
end
