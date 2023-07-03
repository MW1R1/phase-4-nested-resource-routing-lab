Rails.application.routes.draw do
  resources :items, only: [:index]
  resources :users, only: [:show]
  resources :items, only: [:index, :show, :create]
  resources :users, only: [:show] do
    resources :items, only: [:show, :index]
    post 'items', to: 'items#create'
  end

  get '/items', to: 'items#all_items'
end
