require 'rails_helper'

RSpec.describe 'Placar', type: :request do
  describe 'GET /api/v1/placar' do
    it 'is not successful - user not authenticated' do
      get '/api/v1/placar'
      expect(response).to_not have_http_status(:success)
    end
    it 'is not successful - no registred user answers' do
      user = User.create({:username => "heleno", :password => "password", :password_confirmation => "password"})
      post '/api/v1/login', params: { username: user.username, password: user.password }
      token = JSON.parse(response.body)['token']
      get '/api/v1/placar', headers: { 'Authorization': "Bearer #{token}" }
      expect(response).to have_http_status(500)
    end
    it 'is successful - user authenticated and has registred answer' do
      user = User.create({:username => "heleno", :password => "password", :password_confirmation => "password"})
      post '/api/v1/login', params: { username: user.username, password: user.password }
      token = JSON.parse(response.body)['token']
      resposta = create(:user_answer, user: user)
      get '/api/v1/placar', headers: { 'Authorization': "Bearer #{token}" }
      expect(response).to have_http_status(200)
    end
  end
end