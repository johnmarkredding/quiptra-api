Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
			resources :users, only: [:create, :show, :destroy, :update, :index]
			post "/login", to: "users#login", as: "login"
			resources :bookings, only: [:create, :show, :destroy, :update, :index]
			resources :listings, only: [:create, :show, :destroy, :update, :index]
		end
	end
end
