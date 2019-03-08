Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'registrations#new'
  resources :registrations, only: [:new, :create]
  resources :subscriptions, only: [:new, :create, :delete]
  mount Sequent::Engine, at: '/sequent'
end
