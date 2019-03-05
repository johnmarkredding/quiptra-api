class Api::V1::BookingsController < ApplicationController
	before_action :verify_token

	def index
		render json: Booking.all
	end

	def create
		user = User.find(decoded_token["id"])
		split_dates = params[:dates].split("...");
		date_range = (Date.parse(split_dates[0])...Date.parse(split_dates[1]))
		listing = Listing.find(params[:listing_id])
		if (!listing.overlaps_booking_dates?(date_range))
			booking = Booking.new({listing_id: params[:listing_id], renter_id: user.id, dates: date_range, status: "pending"})
			if !!booking.save
				render json: booking
			else
				render json: {message: "Not allowed!!"}
			end
		else
			render json: {message: "Overlapping Dates!!"}
		end
	end

	def current
		user = User.find(decoded_token["id"])
		bookings = user.bookings
		render json: self.blueprint(bookings)
	end

	def pending
		user = User.find(decoded_token["id"])
		bookings = user.booking_requests.where(status: "pending")
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

	def update
		booking = Booking.find(params[:id])
		if !!booking && booking.update(booking_params)
			render json: booking
		else
			render json: {message: "Update failed!!"}
		end
	end

	def blueprint(obj)
		BookingBlueprint.render_as_hash(obj)
	end

	private
	
	def booking_params
		params.require(:booking).permit(:renter_id, :listing_id, :dates, :status)
	end
end
