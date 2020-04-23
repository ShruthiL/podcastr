Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  get '/podcasts', to: "static_pages#index"
  get '/podcasts/new', to: "static_pages#index"

  namespace :api do
    namespace :v1 do
      resources :podcasts, only: [:index, :create]
    end
  end
end
