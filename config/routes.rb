Rails.application.routes.draw do
  # root to: 'prototype#index'
  resources :prototypes, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  devise_for :users
  root to: "prototypes#index"
  
  resources :users do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :users, only: :show

  resources :prototypes do
    resources :comments, only: [:create, :destroy]
  end  
end