class Api::V1::ListingsController < ApplicationController
	before_action :verify_token

	def index
		# listings = Listing.filteredListings(params)
		user = User.find(decoded_token["id"])
		listings = Listing.where.not(owner_id: user.id).select{|x| x.title.downcase.include?(params[:term].downcase) && x.city.downcase.include?(params[:city].downcase) && x.state.downcase.include?(params[:state].downcase)}
		if listings.empty?
			listings = Listing.where.not(owner_id: user.id)
		end
		render json: self.blueprint(listings)
	end

	def current
		user = User.find(decoded_token["id"])
		listings = user.listings
		render json: self.blueprint(listings)
	end

	def create
		user = User.find(decoded_token["id"])
		listing = Listing.new(listing_params)
		listing.owner_id = user.id
		if listing.save
			render json: self.blueprint(listing)
		else
			render :not_acceptable
		end
	end
	
	def show
		listing = Listing.find(params[:id])
		if !!listing
			render json: self.blueprint(listing)
		else
			render :not_found
		end
	end

	def booked_dates
		listing = Listing.find(params[:id])
		if !!listing
			render json: listing.booked_dates
		else
			render json: {message: "Not a valid listing"}
		end
	end

	def blueprint(obj)
		ListingBlueprint.render_as_hash(obj)
	end

	private

	def listing_params
		params.permit(:id, :owner_id, :title, :body, :price, :email, :phone, :street_address, :city, :state, :image_url)
	end
end
