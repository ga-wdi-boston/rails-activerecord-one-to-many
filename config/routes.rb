Spotterfly::Application.routes.draw do
  resources :albums, only: [:create, :new]
  resources :artists, only: [:index, :show, :create]
  root to: 'artists#index'
end
