Rails.application.routes.draw do
  resources :users, only: [:create]
  post "/auth", to: "users#auth"
  #resources :auths, only: [:create]
  resources :addresses, only: [:index, :show]
end
