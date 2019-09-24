Rails.application.routes.draw do
  get 'routes/index'
  get 'routes/show'
  get 'routes(/:id)/stops', to: 'routes#stops'
  get 'routes(/:id)/analitics', to: 'routes#analitics'
  mount ActionCable.server => '/cable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  
  resources :routes
  resources :shapes
  resources :stoptimes
  resources :stops
  resources :trips
  

end
