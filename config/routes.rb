ChessCamp::Application.routes.draw do
  # generated routes
  resources :curriculums
  resources :instructors
  resources :camps
  resources :students
  resources :families
  resources :users
  resources :sessions
  resources :locations
  resources :registrations

  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout

  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy

  get 'printables/payments', to: 'printables#payments', as: :payments
  post 'printables/camp_report', to: 'printables#camp_report', as: :camp_report
  post 'printables/family_report', to: 'printables#family_report', as: :family_report
  # set the root url
  root to: 'home#index'

end
