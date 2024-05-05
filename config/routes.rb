Rails.application.routes.draw do

  # Devise
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Other resources
  resources :users
  resources :tags  

  # Email Capture
  resources :email_captures
  
  # Blog
    resources :categories do
      get 'child_categories', on: :member
    end
    resources :posts, path: 'blog'
    resources :post_authors
    get '/image_resources/:id/permanent_image', to: 'image_resources#permanent_image', as: 'permanent_image'

  # Images
  resources :image_resources
  
  # Publishing related resources
  resources :book_collections, path: 'series'
  resources :books
  resources :book_genres
  resources :book_tropes
  resources :authors

  get 'free-books-download', to: 'books#free_books_download'

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
