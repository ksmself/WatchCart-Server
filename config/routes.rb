Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  begin
    ActiveAdmin.routes(self)
  rescue StandardError
    ActiveAdmin::DatabaseHitDuringLoad
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :users do
    post "token" => "users/refresh#create"
  end

  devise_for :users,
             path: "",
             path_names: {
               sign_in: "login",
               sign_out: "logout",
               registration: "signup"
             },
             controllers: {
               sessions: "users/sessions",
               registrations: "users/registrations"
             }

  resources :categories
  resources :movies
  resources :directors
  resources :actors
  resources :plays
  resources :items
  resources :images do
    post :dropzone, on: :collection
  end
end
