require 'rails_helper'

RSpec.describe 'Cats API Adapter', type: :helper do
  before do
    @cats_adapter = CatsAPIAdapter.new
  end

  describe 'request headers' do
    it 'should contain the api key', :cats_api_key do
      headers = @cats_adapter.request_headers
      expect(headers).not_to be_empty
      expect(headers).to have_key('x-api-key')
    end
  end

  describe 'sending a GET request' do
    describe 'sending a GET request with no params' do
      before do
        @payload = @cats_adapter.get(path: '/breeds')
      end

      it 'should succeed' do
        expect(@payload).to be_kind_of(Array)
      end
    end
  end
end
