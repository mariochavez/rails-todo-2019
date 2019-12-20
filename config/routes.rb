Rails.application.routes.draw do
  resources :todos, only: [:index, :create, :update, :destroy]
end
