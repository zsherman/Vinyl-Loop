Saas::Application.routes.draw do
  devise_for :users

  root to: 'plans#index'
  resources :subscriptions
  resources :plans
end
