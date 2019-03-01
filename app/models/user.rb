class User < ApplicationRecord
	has_many :bookings, foreign_key: :renter_id
	has_many :listings, foreign_key: :owner_id
	has_many :rented_listings, through: :bookings, source: "listing"
	has_many :booking_requests, through: :listings, source: "bookings"
	has_secure_password

	def approved_bookings
		self.bookings.select {|b| b.status == "approved"}
	end

	def requested_bookings
		self.bookings.select {|b| b.status == "pending"}
	end
end