Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
			get "/users/current", to: "users#current"
			post "/login", to: "users#login", as: "login"
			post "/sign-up", to: "users#sign_up", as: "sign_up"
			resources :users, only: [:create, :show, :destroy, :update, :index]
			
			get "/bookings/current", to: "bookings#current"
			get "/bookings/pending", to: "bookings#pending"
			resources :bookings, only: [:create, :show, :destroy, :update, :index]

			get "/listings/current", to: "listings#current"
			get "/listings/:id/booked-dates", to: "listings#booked_dates"
			resources :listings, only: [:create, :show, :destroy, :update, :index]
		end
	end
end
