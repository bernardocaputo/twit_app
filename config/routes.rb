Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :twits, only: [:create, :destroy, :update, :index]
end
