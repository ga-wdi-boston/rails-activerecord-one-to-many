Rails.application.routes.draw do
  # Default root for '/' in this application
  root 'movies#index'

  resources :movies, except: [:new, :edit] do
    resources :reviews, except: [:new, :edit]
  end
end
