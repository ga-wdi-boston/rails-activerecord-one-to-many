Rails.application.routes.draw do
  # Default root for '/' in this application
  root 'movies#index'

  get '/movies', to: 'movies#index'

  # :id will identify a specific movie
  get '/movies/:id', to: 'movies#show'

  # Create a movie.
  post '/movies', to: 'movies#create'

  # Update a movie
  patch '/movies/:id', to: 'movies#update'

  # delete a movie
  delete '/movies/:id', to: 'movies#delete'
end
