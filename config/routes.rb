Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  get 'tutor/index'
  get 'students/index'
  devise_for :tutors
  devise_for :students
  root "home#index"
  resources :tutors do
    resources :courses
  end
  resources :students, only: [:index] do
    resources :transactions
  end
  resources :courses do
    member do
      post :buy
    end
  end
  post '/verify_payment', to: 'transactions#verify_payment'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
end
