class Api::V1::BookingsController < ApplicationController
	before_action :verify_token

	def index
		render json: Booking.all
	end

	def create
		user = User.find(decoded_token["id"])
		split_dates = booking_params[:dates].split("...");
		date_range = (Date.parse(split_dates[0])...Date.parse(split_dates[1]))
		booking = Booking.new({listing_id: booking_params[:listing_id], renter_id: user.id, dates: date_range, status: "pending"})
		if !!booking.save
			render json: booking
		else
			render json: {message: "Not allowed!!"}
		end
	end

	def current
		user = User.find(decoded_token["id"])
		bookings = user.bookings
		render json: self.blueprint(bookings)
	end

	def requested
		user = User.find(decoded_token["id"])
		bookings = user.booking_requests
		render json: self.blueprint(bookings)
	end

	def show
		booking = Booking.find(params[:id])
		if !!booking
			render json: booking
		else
			render :not_found
		end
	end

	def blueprint(obj)
		BookingBlueprint.render_as_hash(obj)
	end

	private
	
	def booking_params
		params.require(:booking).permit(:renter_id, :listing_id, :dates)
	end
end
