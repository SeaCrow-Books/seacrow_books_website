Rails.application.routes.draw do
  
  # Users
  devise_for :users
 
  # Pages
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  # Defines the root path route ("/")
  root "pages#index"

end
