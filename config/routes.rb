Rails.application.routes.draw do
  root 'pages#home'

  get '/signup',       to: "users#new"
  get '/login',        to: "sessions#new"
  get '/logout',       to: "sessions#destroy"
  get '/confirmation', to: "confirmation#show"
  get '/about',        to: "pages#about"
  get '/graphs',       to: "graphs#index"

  namespace :users, as: :user, path: 'users' do
    get '/:user_id/projects', to: "projects#index"
    get '/users/:id/projects/new', to: "projects#new"
  end
  resources :users, only: [:new, :create, :index]

  resources :categories, only: [:index, :show]
  resources :rewards, only: [:index, :create, :new]
  resources :projects, only: [:index, :show, :edit, :new, :create], param: :slug

  namespace :projects do
    get '/:project_id/rewards', to: "rewards#index", as: "rewards"
  end

  get '/checkout/:reward_id', to: "payments#new", as: "checkout"


  resources :sessions, only: [:new, :create, :destroy] do
    post :authorization, on: :collection
  end
  resources :payments, only: [:create]

  resources :locations, only: [:new, :create]

  namespace :api do
    namespace :v1 do

      namespace :projects do
        get '/most_funded', to: 'most_funded#index'
      end
      resources :projects, only: [:show, :index]

      namespace :locations do
        get '/location_with_most_projects', to: 'location_with_most_projects#show'
      end

      namespace :users do
        get '/biggest_donor', to: 'biggest_donor#show'
      end
    end
  end
end
