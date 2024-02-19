Rails.application.routes.draw do
  resources :logins, only: [:new]
  get "auth/google_oauth2/callback" => "logins#create"

  resources :chats
  resources :chat_messages

  get "up" => "rails/health#show", as: :rails_health_check
end
