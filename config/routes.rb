Rails.application.routes.draw do
  namespace :api do
    resources :channels, only: [:index, :show, :create, :update, :destroy]
    resources :messages, only: [:index, :show, :create]
  end
end
