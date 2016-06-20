Rails.application.routes.draw do
  resources :people, except: [:new, :edit]
  resources :cities, except: [:new, :edit]
end
