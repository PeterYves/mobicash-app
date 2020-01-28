Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers
      resources :products
    end
  end

  post 'refresh', controller: :refresh, action: :create
  post 'signin', controller: :signin, action: :create
  post 'signup', controller: :signup, action: :create
  delete 'signin', controller: :signin, action: :destroy
  
  root to: "customers#index"
end
