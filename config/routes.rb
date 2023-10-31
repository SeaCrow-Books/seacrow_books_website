Rails.application.routes.draw do

  get 'dashboards/show'

  # Chats
  resources :chat_sessions do
    resources :chats, only: [:create]
  end  

  resources :chat_custom_instructions
  resources :ai_models
  
  # Devise
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Resources
  Rails.application.routes.draw do
    resources :books, except: [:index]
    resources :genres
    resources :categories, except: [:index]
    resources :users
    resources :authors, except: [:index]
    resources :image_resources
  end  

  # Personas
  resources :personas do
    resources :persona_versions
  end
  
  # Site config
  patch 'update_account_creation_permission', to: 'site_configs#update_account_creation_permission'
  get 'run_seed', to: 'site_configs#run_seed'

  # Pages
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'privacy-policy', to: 'pages#privacy_policy'

  # Dashboard
  get 'dashboard', to: 'dashboards#show', as: 'dashboard'

  # Blog
  resources :posts, path: 'blog'

  # Sets permanant image url
  get '/image_resources/:id/permanent_image', to: 'image_resources#permanent_image', as: 'permanent_image'

  # Defines the root path route ("/")
  root "posts#index"

end
