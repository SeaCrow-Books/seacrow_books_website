Rails.application.routes.draw do
  resources :authors
  get 'dashboards/show'

  # Devise
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Resources
  resources :books, :genres, :categories, :users, :authors

  # Site config
  patch 'update_account_creation_permission', to: 'site_configs#update_account_creation_permission'
  # get 'run_seed', to: 'site_configs#run_seed'

  # Pages
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  # Dashboard
  get 'dashboard', to: 'dashboards#show', as: 'dashboard'

  # Blog
  resources :posts, path: 'blog'

  # Defines the root path route ("/")
  root "pages#index"

end
