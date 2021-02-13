Rails.application.routes.draw do
  resources :users
  resources :schedules
  root 'schedules#show'
end
