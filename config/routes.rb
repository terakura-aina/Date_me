Rails.application.routes.draw do
  resources :schedules
  root 'schedules#show'
end
