Rails.application.routes.draw do
  get 'make_plans/create'
  resources :users, only: [:create]
  resources :schedules, only: [:create, :new, :update, :index]
  resources :make_plans, only: [:create]
  
  root 'schedules#show'
  get '/schedules/:token' => 'schedules#edit'
end
