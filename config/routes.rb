Rails.application.routes.draw do

  get 'dashboards/show'

  # Devise
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Resources
  Rails.application.routes.draw do
    resources :genres
    resources :users
    resources :authors, except: [:index]
    resources :image_resources
    resources :chat_custom_instructions
    resources :ai_models
    resources :tags  
  end  

  # Books
  resources :books do
    resources :book_sections do
      patch :update_position, on: :member
    end
  end
  
  


  # Categories
  resources :categories do
    get 'child_categories', on: :member
  end

  # Chats
  resources :chat_sessions do
    resources :chats, only: [:create]
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
  root "pages#home"

end
