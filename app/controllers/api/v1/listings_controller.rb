class Api::V1::ListingsController < ApplicationController
	before_action :verify_token

	def index
		# listings = Listing.filteredListings(params)
		listings = Listing.all.select{|x| x.title.include?(params[:term]) && x.city.include?(params[:city]) && x.state.include?(params[:state])}
		render json: listings
	end

	def create
		listing = Listing.new(listing_params)
		if listing.save
			render json: listing
		else
			render :not_acceptable
		end
	end
	
	def show
		listing = Listing.find(params[:id])
		if !!listing
			render json: listing
		else
			render :not_found
		end
	end

	private

	def listing_params
		params.permit(:owner_id, :title, :body, :price, :email, :phone, :street_address, :city, :state, :image_url)
	end
end
