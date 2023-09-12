Rails.application.routes.draw do

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)
  
  resources :series, only: [:index, :show]
  resources :series do
    member do
      get 'fetch_series'
      post 'import_series'
      post 'fetch_cast'
    end
  end

  # rotas api
  namespace :api do
    namespace :v1, defaults: { format: :json } do

      post 'login',     to: "login#login"
      post 'resposta',  to: "resposta#resposta"
      get  'questao',   to: "questao#questao"
      get  'placar',    to: "placar#placar"

    end
  end

end
