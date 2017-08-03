Rails.application.routes.draw do
  resources :faqs, only: :index
  resources :tutorials, only: :index

  get '/service-specific-information', to: 'service_specific_information#index', as: 'service_specific_information'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
