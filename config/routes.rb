Rails.application.routes.draw do
  resources :tutorials, only: :index
  resources :faqs, only: :index

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
