Rails.application.routes.draw do
  devise_for :users
  resources :contacts, only: [:new, :create, :index] 
  resources :contact_sources do
    get 'match_headers'
  end
  root 'main#home'
end
