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

  # as를 붙이면 get 방식이 아닌 post 방식을 바로 호출할 수 있다.
  post '/movies/:id/like', to: 'likes#like_toggle', as: 'like'
  get '/movies/:id/like' => 'likes#is_like'
  
  get '/movies/search' => 'movies#search'

  post '/movies/:id/good', to: 'ratings#good_toggle', as: 'good'
  get '/movies/:id/good' => 'ratings#is_good'
  post '/movies/:id/bad', to: 'ratings#bad_toggle', as: 'bad'
  get '/movies/:id/bad' => 'ratings#is_bad'

  resources :users
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: 'index'
    get '(:id/page/:page)', action: :show, on: :collection, as: 'show'
  end
  
  resources :categories , concerns: :paginatable
  resources :movies
  resources :orders
  resources :lineitems
  resources :directors
  resources :actors
  resources :plays
  resources :items
  resources :images do
    post :dropzone, on: :collection
  end
end
