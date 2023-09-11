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
  namespace :admin do
    resources :quizzes
  end
end
