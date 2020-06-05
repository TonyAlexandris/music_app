Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'bands#index'
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :bands
  resources :bands do
    resources :albums, only: [:new]
  end
  resources :albums, except: [:index, :new]
  resources :albums do
    resources :tracks, only: [:new]
  end
  resources :tracks, except: [:index, :new]
  resources :notes, only: [:create, :destroy]
end
