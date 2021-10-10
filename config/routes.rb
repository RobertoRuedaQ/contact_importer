Rails.application.routes.draw do
  devise_for :users
  resources :contact_sources
  resources :contacts  
  root 'main#home'
end
