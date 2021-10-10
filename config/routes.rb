require 'sidekiq/web'
Rails.application.routes.draw do
  
  devise_for :users
  resources :contacts, only: [:new, :create, :index] 
  resources :contact_sources do
    get 'match_headers'
    post 'create_contacts_from_list'
  end
  mount Sidekiq::Web => "/sidekiq"
  
  root 'main#home'
end
