Rails.application.routes.draw do
  devise_for :users
  resources :contacts  
  resources :contact_sources do
    get 'match_headers'
  end
  root 'main#home'
end
