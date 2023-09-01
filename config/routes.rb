Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :series, only: [:index]
  resources :series do
    member do
      post 'fetch_cast'
      post 'import_series'
    end
  end
end
