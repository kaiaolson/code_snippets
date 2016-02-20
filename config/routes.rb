Rails.application.routes.draw do
  resources :code_snippets
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  resources :sessions, only: [:new, :create, :destroy] do
    delete :destroy, on: :collection
  end

  root "code_snippets#index"
end
