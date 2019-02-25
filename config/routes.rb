Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
			resources :users, only: [:create, :show, :destroy, :update, :index]
			post "/login", to: "users#login", as: "login"
			post "/sign-up", to: "users#sign_up", as: "sign_up"
			resources :bookings, only: [:create, :show, :destroy, :update, :index]
			resources :listings, only: [:create, :show, :destroy, :update, :index]
		end
	end
end
