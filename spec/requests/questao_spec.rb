require 'rails_helper'

RSpec.describe 'Questao', type: :request do
  describe 'GET /api/v1/questao' do
    it 'is not successful - user not authenticated' do
      get '/api/v1/questao'
      expect(response).to_not have_http_status(:success)
    end
    it 'is successful - user authenticated' do
      user = User.create({:username => "heleno", :password => "password", :password_confirmation => "password"})
      post '/api/v1/login', params: { username: user.username, password: user.password }
      token = JSON.parse(response.body)['token']
      series = create_list(:series, 10)
      character = create(:character)
      get '/api/v1/questao', headers: { 'Authorization': "Bearer #{token}" }
      expect(response).to have_http_status(:success)
    end
  end
end