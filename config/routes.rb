Rails.application.routes.draw do

  # Devise
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Other resources
  resources :users
  resources :tags  
  
  namespace :blog do
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
  
  # Publishing related resources
  resources :book_collections, path: 'series'
  resources :books
  resources :book_genres
  resources :book_tropes
  resources :authors

  # Site config related routes
  patch 'update_account_creation_permission', to: 'site_configs#update_account_creation_permission'
  get 'run_seed', to: 'site_configs#run_seed'

  # Static pages
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'privacy-policy', to: 'pages#privacy_policy'
  get 'trigger-support', to: 'pages#trigger_support'

  # Dashboard
  get 'blog_dashboard', to: 'dashboards#blog'
  get 'book_dashboard', to: 'dashboards#book'
  get 'admin_dashboard', to: 'dashboards#admin'

  # Root path
  root "pages#home"

  # Nested routes for book_collections and books
  resources :book_collections, path: '/', except: [:show] do
    resources :books, path: '/'
    get ':id', to: 'book_collections#show', as: 'show', on: :collection
  end

end
