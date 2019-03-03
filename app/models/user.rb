class User < ApplicationRecord
	has_many :bookings, foreign_key: :renter_id
	has_many :listings, foreign_key: :owner_id
	has_many :booking_requests, through: :listings, source: "bookings"
	has_secure_password

	def requested_listings
		self.requested_bookings.map{|b| b.listing}
	end

	def approved_listings
		self.approved_bookings.map{|b| b.listing}
	end

	def approved_bookings
		self.bookings.where(status: "approved")
	end

	def requested_bookings
		self.bookings.where(status: "pending")
	end
end