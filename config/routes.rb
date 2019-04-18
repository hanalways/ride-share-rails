Rails.application.routes.draw do
  get "passengers/index"
  get "trips/index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "trips#index"
  resources :drivers
  resources :passengers
  resources :trips
  patch "/trips/new", to: "drivers#complete", as: "driver_status"
end
