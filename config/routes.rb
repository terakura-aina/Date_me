Rails.application.routes.draw do
  resources :users, only: [:create]
  resources :schedules, only: [:create, :new, :update, :index, :destroy]
  resources :make_plans, only: [:create]
  resources :today_missions, only: [:update]
  resource :session, only: [:show, :create]

  root 'schedules#show'
  get '/missions/:token/:user' => 'missions#index'
  get '/schedules/:token' => 'schedules#edit'
  get '/terms' => 'settings#terms'
  get '/privacy' => 'settings#privacy'

  post '/callback' => 'linebot#callback'
end
