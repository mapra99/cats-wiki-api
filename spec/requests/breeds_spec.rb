require 'rails_helper'

RSpec.describe 'Breeds endpoints', type: :request do
  describe 'GET /search-breed with valid query term' do
    before do
      get '/search-breed?term=be'
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

  describe 'GET /search-breed with no query term' do
    before do
      get '/search-breed?term='
    end

    it 'should respond with an ok status' do
      expect(response).to have_http_status(400)
    end
  end
end
