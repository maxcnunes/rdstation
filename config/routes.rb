Rdstation::Application.routes.draw do
  get "sessions/new"
  root :to => "users#new"

  resources :users
  resources :people
  resources :sessions

  # Pipedrive
  get "pipedrive_configs" => "pipedrive_configs#index"
  post "pipedrive_configs/app_key"
  delete "pipedrive_configs" => "pipedrive_configs#destroy"

  # Authetication
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
end
