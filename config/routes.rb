Rails.application.routes.draw do
  get 'dashboards/show'
  
  # Users
  devise_for :users
 
  # Pages
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  # Dashboard
  get 'dashboard', to: 'dashboards#show', as: 'dashboard'

  # Resources
  resources :books, :genres, :categories

  # Blog
  resources :posts, path: 'blog'

  # Defines the root path route ("/")
  root "pages#index"

end
