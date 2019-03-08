# frozen_string_literal: true

Rails.application.routes.draw do
  root "books#index"
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
