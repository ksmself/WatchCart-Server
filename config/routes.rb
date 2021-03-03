Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :users do
    post "token" => "users/refresh#create"
  end

  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }

  api_version(module: "V1", header: {name: "Accept-Version", value: "v1"}) do
    resources :categories
    resources :items
    resources :users
    resources :images do 
      post :dropzone, on: :collection
    end
    resources :comments
    resources :notices
    resources :faqs, only: :index
    namespace :phone_certifications do
      get :sms_auth
      get :check
    end
    resources :likes, only: %i[index create destroy]
    resources :contacts, only: %i[index show create]
    resources :follows, only: %i[create destroy]
    resources :objects
  end
end


