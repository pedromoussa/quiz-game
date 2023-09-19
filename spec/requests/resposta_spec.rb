require 'rails_helper'

RSpec.describe 'Resposta', type: :request do
  describe 'POST /api/v1/resposta' do
    it 'is not successful - user not authenticated' do
      post '/api/v1/resposta'
      expect(response).to have_http_status(401)
    end
    it 'is not successful - missing character param' do
      user = User.create({:username => "heleno", :password => "password", :password_confirmation => "password"})
      post '/api/v1/login', params: { username: user.username, password: user.password }
      token = JSON.parse(response.body)['token']
      series = create(:series)
      post '/api/v1/resposta', params: {:character_id => nil, :series_id => series.id }, headers: { 'Authorization': "Bearer #{token}" }
      expect(response).to have_http_status(500)
    end
    it 'is not successful - missing series param' do
      user = User.create({:username => "heleno", :password => "password", :password_confirmation => "password"})
      post '/api/v1/login', params: { username: user.username, password: user.password }
      token = JSON.parse(response.body)['token']
      character = create(:character)
      post '/api/v1/resposta', params: {:character_id => character.id, :series_id => nil }, headers: { 'Authorization': "Bearer #{token}" }
      expect(response).to have_http_status(500)
    end
    it 'is not successful - incorrect answer' do
      user = User.create({:username => "heleno", :password => "password", :password_confirmation => "password"})
      post '/api/v1/login', params: { username: user.username, password: user.password }
      token = JSON.parse(response.body)['token']
      character = create(:character)
      series = create(:series)
      post '/api/v1/resposta', params: {:character_id => character.id, :series_id => series.id }, headers: { 'Authorization': "Bearer #{token}" }
      expect(response).to have_http_status(422)
    end
    it 'is successful - correct answer' do
      user = User.create({:username => "heleno", :password => "password", :password_confirmation => "password"})
      post '/api/v1/login', params: { username: user.username, password: user.password }
      token = JSON.parse(response.body)['token']
      character = create(:character)
      associated_series = Series.find_by(id: character.series_id)
      post '/api/v1/resposta', params: {:character_id => character.id, :series_id => associated_series.id }, headers: { 'Authorization': "Bearer #{token}" }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq('Parabens, você acertou!')
    end
  end
end