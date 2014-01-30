Spotterfly::Application.routes.draw do
  resources :albums, only: [:create, :new]
  resources :artists, only: [:index, :show, :create]

  # We can nest either way
  # In reality, we'd probably just one want way
  resources :authors do
    resources :books
  end

  resources :books do
    resources :authors
  end

  root to: 'artists#index'
end
