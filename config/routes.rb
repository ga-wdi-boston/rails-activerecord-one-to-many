Rails.application.routes.draw do

  resources :albums, only: [:index, :show]
  root 'albums#index'

  resources :songs, only: [:index, :show]

end
