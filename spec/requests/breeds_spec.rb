require 'rails_helper'

RSpec.describe 'Breeds endpoints', type: :request do
  describe 'GET /breeds/search' do
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

      it 'should return by default 1 image per search result' do
        payload = JSON.parse(response.body)
        expect(payload.pluck('images')).not_to be_empty
        expect(payload.pluck('images')).to be_kind_of(Array)
        expect(payload.pluck('images')[0].length).to eq(1)
      end
    end

    describe 'with no query term' do
      before do
        get '/breeds/search?term='
      end

      it 'should respond with an bad request status' do
        expect(response).to have_http_status(400)
      end
    end

    describe 'images in search results' do
      describe 'specifying the amount of images wanted per result' do
        before do
          get '/breeds/search?term=be&images_limit=5'
        end
  
        it 'should respond with an ok status' do
          expect(response).to have_http_status(200)
        end
  
        it 'should return in the payload 5 images per search result' do
          payload = JSON.parse(response.body)
          expect(payload.pluck('images')).not_to be_empty
          expect(payload.pluck('images')).to be_kind_of(Array)
          expect(payload.pluck('images')[0].length).to eq(5)
        end
      end

      describe 'wanting 0 images per result' do
        before do
          get '/breeds/search?term=be&images_limit=0'
        end

        it 'should respond with an ok status' do
          expect(response).to have_http_status(200)
        end

        it 'should return in the payload 0 images per search result' do
          payload = JSON.parse(response.body)
          expect(payload.pluck('images')).not_to be_empty
          expect(payload.pluck('images')).to be_kind_of(Array)
          expect(payload.pluck('images')[0].length).to eq(0)
        end
      end
    end

    describe 'searching by name or by id' do
      xit 'should search by name when passed a query param'
      xit 'should search by breed id when passed a query param'
    end
  end

  describe 'GET /breeds/top-searches' do
    let!(:successful_searches_one) { create_list(:breed_search_result, 5, breed_id: 'abys') }
    let!(:successful_searches_two) { create_list(:breed_search_result, 10, breed_id: 'beng') }
    let!(:successful_searches_three) { create_list(:breed_search_result, 2, breed_id: 'aege') }
    let!(:failed_searches) { create_list(:failed_breed_search, 10) }
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

    it 'should return by default 1 image per top result' do
      payload = JSON.parse(response.body)
      expect(payload.pluck("images")).not_to be_empty
      expect(payload.pluck("images")).to be_kind_of(Array)
    end
  end

  describe 'GET /breeds/images' do
    before do
      get '/breeds/images?breed_id=beng&images_limit=5'
    end

    it 'should respond with an ok status' do
      payload = JSON.parse(response.body)
      expect(payload).not_to be_empty
      expect(response).to have_http_status(200)
    end

    it 'should return an array with the image urls' do
      payload = JSON.parse(response.body)
      expect(payload).not_to be_empty
      expect(payload).to be_kind_of(Array)
      expect(payload[0]).to be_kind_of(String)
      expect(response).to have_http_status(200)
    end
  end
end
