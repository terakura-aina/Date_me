Rails.application.routes.draw do
  get 'today_missions/update'
  resources :users, only: [:create]
  resources :schedules, only: [:create, :new, :update, :index, :destroy]
  resources :make_plans, only: [:create]
  resources :today_missions, only: [:update]

  root 'schedules#show'
  get '/missions/:token/:user' => 'missions#index'
  get '/schedules/:token' => 'schedules#edit'
end
