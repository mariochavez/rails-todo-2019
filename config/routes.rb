Rails.application.routes.draw do
  resources :todos, only: [:index, :create, :destroy]

  root "todos#index"
end
