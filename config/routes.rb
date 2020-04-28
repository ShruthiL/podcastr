Rails.application.routes.draw do
  root 'static_pages#index'
  devise_for :users

  get '/podcasts', to: "static_pages#index"
  get '/podcasts/:id', to: "static_pages#index"

  namespace :api do
    namespace :v1 do
      resources :podcasts, only: [:index, :show]
      resources :reviews, only: [:index]
    end
  end
end
