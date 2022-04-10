Rails.application.routes.draw do
  resources :memberships, only: %i[index create]
  resources :clients, only: %i[index update show]
  resources :gyms, only: %i[index update show destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
