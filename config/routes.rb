Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'registrations#new'
  resources :registrations, only: [:new, :create]
  resource :subscription, only: [:new, :create, :show, :destroy]
  resources :notifications, only: [] do
    put :mark_as_read
  end
  mount Sequent::Engine, at: '/sequent'
end
