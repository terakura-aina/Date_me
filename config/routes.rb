Rails.application.routes.draw do
  resources :users, only: [:create]
  resources :schedules, only: [:create, :new, :update, :index, :destroy]
  resources :make_plans, only: [:create]

  root 'schedules#show'
  get '/missions/:token/:user' => 'missions#index'
  get '/schedules/:token' => 'schedules#edit'
end
