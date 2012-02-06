Saas::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => 'registrations'}

  root to: 'plans#index'
  resources :subscriptions
  resources :plans
  resources :pages
  resources :prospects
  match '/home', :to => 'pages#home'
  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
  match '/dashboard', :to => 'users#dashboard'
end
