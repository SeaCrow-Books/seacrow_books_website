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

  # Blog
  namespace :blog do
    resources :posts, path: '/'
    resources :categories do
      get 'child_categories', on: :member
    end
    resources :image_resources

    # Adding the new route within the blog namespace
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
    resources :authors, except: [:index]
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

  # Dashboard
  get 'dashboard', to: 'dashboards#show', as: 'dashboard'

  # Defines the root path route ("/")
  root "pages#home"

end
