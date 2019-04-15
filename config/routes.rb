Rails.application.routes.draw do
  get 'trips/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "trips#index"
  resources :trips
  resources :drivers
  resources :passengers
end
