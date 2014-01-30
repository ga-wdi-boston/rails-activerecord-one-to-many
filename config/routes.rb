SharedBlog::Application.routes.draw do
  root to: 'articles#index'

  resources :users do
    resources :articles do
      resources :comments
    end
  end
end
