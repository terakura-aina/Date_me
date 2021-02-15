Rails.application.routes.draw do
  resources :users, only: [:create]
  resources :schedules, only: [:create, :new, :update, :index]
  resources :make_plans, only: [:create]
  
  root 'schedules#show'
  get '/schedules/:token' => 'schedules#edit'
end
