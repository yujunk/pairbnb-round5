

Rails.application.routes.draw do

	root "welcome#index"

	resources :products

	get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
