Rails.application.routes.draw do


  devise_for :users
  resources :albums, only: [:index, :show] do
    # All songs require a nested route.
    resources :songs, only: [:index, :show]
  end
  root 'albums#index'



end
