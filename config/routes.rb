Rails.application.routes.draw do
  # Auth Routes
  get "sign_in" => "authentication#sign_in"
  get "signed_out" => "authentication#signed_out"
  get "change_password" => "authentication#change_password"
  get "forgot_password" => "authentication#forgot_password"
  get "new_user" => "authentication#new_user"
  get "password_sent" => "authentication#password_sent"
  post "sign_in" => "authentication#login"
  post "new_user" => "authentication#register"
  get "account_settings" => "authentication#account_settings"
  put "account_settings" => "authentication#set_account_info"

  resources :users

  resources :questions do
    resources :answers
  end

  get 'credits' => 'home#credits'
  root 'home#index'
end
