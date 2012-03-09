Saas::Application.routes.draw do
  break if ARGV.join.include? 'assets:precompile'
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, :controllers => {:registrations => 'registrations'}
  root to: 'pages#home'
  resources :subscriptions do
    member do
      get  :edit_payment
      put  :update_payment
    end
  end
  resources :plans
  resources :pages
  resources :prospects
  resources :users do
    member do
      put :update_payment
    end
  end
  match '/home', :to => 'pages#home'
  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
  match '/dashboard', :to => 'users#dashboard'
  match '/edit_payment', :to => 'users#edit_payment'
  match '/edit_password', :to => 'users#edit_password'
  match '/taste_profile', :to => 'users#taste_profile'
  match '/stripe_event', :to => 'users#stripe_event', :via => :post

  
  #
  
end