require 'rails_helper'

RSpec.describe 'User Clicks endpoints', type: :request do
  describe 'POSST /user_clicks' do
    describe 'creating a valid user click' do
      before do
        @user_click_attributes = attributes_for(:user_click)
        post '/user_clicks', params: { user_click: @user_click_attributes }
      end

      it 'should respond with an ok status' do
        payload = JSON.parse(response.body)
        expect(payload).not_to be_empty
        expect(response).to have_http_status(200)
      end

      it 'should return the created object fields' do
        payload = JSON.parse(response.body)
        expect(payload['id']).not_to be_nil
        expect(payload['path_name']).to eq(@user_click_attributes[:path_name])
        expect(payload['clicks_amount']).to eq(@user_click_attributes[:clicks_amount])
      end
    end

    describe 'sending an empty request' do
      before do
        @user_click_attributes = attributes_for(:user_click)
        post '/user_clicks', params: { user_click: {path_name: ''} }
      end

      it 'should respond with a bad request status' do
        payload = JSON.parse(response.body)
        expect(payload).not_to be_empty
        expect(response).to have_http_status(400)
      end
    end
  end
end
