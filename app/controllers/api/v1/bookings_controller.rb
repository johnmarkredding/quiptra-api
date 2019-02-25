class Api::V1::BookingsController < ApplicationController
	before_action :verify_token

	def index
		render json: Booking.all
	end

	def create
		booking = Booking.new(booking_params)
		if booking.save
			render json: booking
		else
			render :not_acceptable
		end
	end

	def show
		booking = Booking.find(params[:id])
		if !!booking
			render json: booking
		else
			render :not_found
		end
	end

	private
	
	def booking_params
		params.permit(:renter_id, :listing_id, :dates)
	end
end
