Rails.application.routes.draw do
  resources :users, only: [:create]
  resources :schedules, only: [:create, :new, :update, :index, :destroy]
  resources :make_plans, only: [:create]
  resources :today_missions, only: [:update]

  root 'schedules#show'
  get '/message' => 'schedules#message'
  get '/login' => 'schedules#login'
  get '/indexlogin' => 'schedules#indexlogin'
  get '/missions/:token/:user' => 'missions#index'
  get '/schedules/:token' => 'schedules#edit'
  get '/terms' => 'settings#terms'
  get '/privacy' => 'settings#privacy'
  get '/top' => 'settings#top'
  get 'description' => 'settings#description'

  post '/callback' => 'linebot#callback'
end
