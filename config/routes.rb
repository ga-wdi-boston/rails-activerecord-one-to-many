SharedBlog::Application.routes.draw do
  devise_for :admins
  root to: 'articles#index'

  resources :users do
    resources :articles do
      resources :comments
    end
  end
end
