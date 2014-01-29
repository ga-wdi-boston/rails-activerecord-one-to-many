Spotterfly::Application.routes.draw do
  resources :artists
  root to: 'artists#index'
end
