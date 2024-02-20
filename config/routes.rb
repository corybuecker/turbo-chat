Rails.application.routes.draw do
  resources :logins, only: [:new]
  get "auth/google_oauth2/callback" => "logins#create"

  resources :users, only: [:edit, :update]

  resources :chats do
    resources :messages
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
