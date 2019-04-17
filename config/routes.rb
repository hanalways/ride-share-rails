Rails.application.routes.draw do
  get "passengers/index"
  get "trips/index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "trips#index"
  resources :trips
  resources :drivers
  resources :passengers do
    resources :trips, only: [:create]

    # resources :passengers do
    #   resources :trips, only: [:index, :new]
    end
  end
end
