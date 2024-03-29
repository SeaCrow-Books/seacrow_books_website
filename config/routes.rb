Rails.application.routes.draw do

  get 'dashboards/show'

  # Devise
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Resources
  Rails.application.routes.draw do
    resources :users
    resources :chat_custom_instructions
    resources :ai_models
    resources :tags  
  end  

  namespace :blog do
    resources :writer_engagements, only: [:index, :destroy, :show, :edit, :update]
  
    resources :categories do
      get 'child_categories', on: :member
    end
    resources :image_resources
    resources :posts, path: '/' do
      resources :writer_engagements, only: [:create]
    end
    
    resources :post_authors
    
    get '/image_resources/:id/permanent_image', to: 'image_resources#permanent_image', as: 'permanent_image'
  end
  
  # Publishing
  namespace :publishing do
    resources :books do
      resources :book_sections do
        patch :update_position, on: :member
      end
    end
    resources :genres
    resources :authors
    resources :book_collections
  end

  # Chats
  resources :chat_sessions do
    resources :chats, only: [:create]
  end  
  
  # Site config
  patch 'update_account_creation_permission', to: 'site_configs#update_account_creation_permission'
  get 'run_seed', to: 'site_configs#run_seed'

  # Pages
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'privacy-policy', to: 'pages#privacy_policy'
  get 'trigger-support', to: 'pages#trigger_support'

  # Dashboard
  get 'dashboard', to: 'dashboards#show', as: 'dashboard'

  # Defines the root path route ("/")
  root "pages#home"

end
