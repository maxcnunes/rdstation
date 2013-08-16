Rdstation::Application.routes.draw do
  get "sessions/new"
  root :to => "users#new"

  resources :users
  resources :people
  resources :sessions

  # Pipedrive
  post "pipedrive_configs/create"

  # Authetication
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
end
