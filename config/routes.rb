Rails.application.routes.draw do
  resources :entitlements, only: [:index, :show]
  resources :tutorials, only: [:index, :show]

  get '/customer-service', to: 'customer_service#index', as: 'customer_service'
  get '/faqs', to: 'faqs#index', as: 'faqs'

  get '/resources/locator-maps(/:latitude,:longitude)', to: 'offices#index', as: 'offices', constraints: {
    latitude: /[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?)/,
    longitude: /[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)/
  }

  post '/resources/locator-maps', to: 'offices#index'
  get '/resources/weight-estimator', to: 'weight_estimator#index', as: 'weight_estimator'
  get '/service-specific-information(/:id)', to: 'service_specific_information#show', as: 'service_specific_information'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
