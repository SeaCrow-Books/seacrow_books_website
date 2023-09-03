Rails.application.routes.draw do
  get 'dashboards/show'
  
  # Users
  devise_for :users
 
  # Pages
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  # Dashboard
  get 'dashboard', to: 'dashboards#show', as: 'dashboard'

  # books
  resources :books

  # Genres
  resources :genres

  # Defines the root path route ("/")
  root "pages#index"

end
