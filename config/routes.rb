#rails generate clearance:routes

Rails.application.routes.draw do

  get 'payment/new'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create, :edit, :show] do
    resource :password, controller: "clearance/passwords", only: [:create, :edit, :update]
    resources :reservations
  end
  #resource will not create :id/ in path and is applicable here cause password is a column, not a model/table
  #resources will create :id/ in path, and relates to the database's :id

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
	root "welcome#index"

	resources :products

	get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :listings do
    resource :reservations, only: [:new, :create] do
      resource :payments, controller: "payments", only: [:new, :create]
    end
  end

  get "/users/:user_id/listings" => "users#user_listing", as: "user_listing"

  post '/listings/:listing_id/reservations/payments/checkout' => "payments#checkout", controller: "payments", as: "payments_checkout"

  post 'search', to: "listings#search"

  post 'filter', to: "listings#filter"
  
end
