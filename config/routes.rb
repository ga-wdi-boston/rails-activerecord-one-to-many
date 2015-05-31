Rails.application.routes.draw do
  # Default root for '/' in this application
  root 'movies#index'

  # create routes for movie resource
  resources :movies, except: [:new, :edit]
end
