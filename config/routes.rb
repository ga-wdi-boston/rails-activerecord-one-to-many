Rails.application.routes.draw do
  resources :pets, except: [:new, :edit]
  resources :songs, except: [:new, :edit]
  resources :albums, except: [:new, :edit]
  resources :people, except: [:new, :edit]
  resources :cities, except: [:new, :edit]
end
