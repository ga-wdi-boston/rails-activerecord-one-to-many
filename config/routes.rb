Rails.application.routes.draw do

  resources :albums, only: [:index, :show]

  resources :songs, only: [:index, :show]

  # Set the root route .
  # This will be the controller/action that gets 
  # called when you enter '/'
  root 'albums#index'

end
