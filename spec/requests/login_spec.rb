require 'rails_helper'

RSpec.describe 'Login', type: :request do
  describe 'POST /api/v1/login' do
    it "is not successful - missing username" do
      user = User.create({:username => "heleno", :password => "password", :password_confirmation => "password"})
      post '/api/v1/login', params: { username: nil, password: user.password }
      expect(response).to_not have_http_status(:success)
    end
    it "is not successful - missing password" do
      user = User.create({:username => "heleno", :password => "password", :password_confirmation => "password"})
      post '/api/v1/login', params: { username: user.username, password: nil }
      expect(response).to_not have_http_status(:success)
    end
    it "is not successful - username mismatch" do
      user = User.create({:username => "heleno", :password => "password", :password_confirmation => "password"})
      post '/api/v1/login', params: { username: "helena", password: user.password }
      expect(response).to_not have_http_status(:success)
    end
    it "is not successful - password mismatch" do
      user = User.create({:username => "heleno", :password => "password", :password_confirmation => "password"})
      post '/api/v1/login', params: { username: user.username, password: "passport" }
      expect(response).to_not have_http_status(:success)
    end
    it 'is successful - code 200' do
      user = User.create({:username => "heleno", :password => "password", :password_confirmation => "password"})
      post '/api/v1/login', params: { username: user.username, password: user.password }
      expect(response).to have_http_status(:success)
    end
    it 'is successful - has token' do
      user = User.create({:username => "heleno", :password => "password", :password_confirmation => "password"})
      post '/api/v1/login', params: { username: user.username, password: user.password }
      expect(JSON.parse(response.body)['token']).to_not be_nil
    end
  end
end