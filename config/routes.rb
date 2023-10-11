Rails.application.routes.draw do

  get 'dashboards/show'

  # Devise
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Resources
  Rails.application.routes.draw do
    resources :books, except: [:index]
    resources :genres
    resources :categories, except: [:index]
    resources :users
    resources :authors, except: [:index]
  end  

  # Personas
  resources :personas do
    resources :persona_versions
  end
  
  # Site config
  patch 'update_account_creation_permission', to: 'site_configs#update_account_creation_permission'
  # get 'run_seed', to: 'site_configs#run_seed'

  # Pages
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'privacy-policy', to: 'pages#privacy_policy'

  # Dashboard
  get 'dashboard', to: 'dashboards#show', as: 'dashboard'

  # Blog
  resources :posts, path: 'blog'

  # Defines the root path route ("/")
  root "pages#home"

end
