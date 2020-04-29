Rails.application.routes.draw do
  root 'static_pages#index'
  devise_for :users

  get '/podcasts', to: "static_pages#index"
  get '/podcasts/new', to: "static_pages#index"
  get '/podcasts/:id', to: "static_pages#index"

  namespace :api do
    namespace :v1 do
      resources :podcasts, only: [:index, :create, :show] do
        resources :reviews, only: [:create]
      end
    end
  end
end
