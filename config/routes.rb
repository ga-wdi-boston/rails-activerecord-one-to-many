Rails.application.routes.draw do

  devise_for :users
  # Parent resource
  resources :albums do 
    # The URLs for songs indicate which album 
    # the song is in. 
    # Child resource
    # resources :songs, only: [:index, :show, :new, :create]    
    resources :songs
    
    # Look at rake routes, http://localhost:3000/rails/info/routes
  end
  
  # Set the root route .
  # This will be the controller/action that gets 
  # called when you enter '/'
  root 'albums#index'

end
