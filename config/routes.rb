Rails.application.routes.draw do

  resources :albums, only: [:index, :show] do
    resources :songs
  end

  resources :songs

  root 'albums#index'

end
