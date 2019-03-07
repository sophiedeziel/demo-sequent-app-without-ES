Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'registrations#new'
  resource :registrations, only: [:new, :create]
  mount Sequent::Engine, at: '/sequent'
end
