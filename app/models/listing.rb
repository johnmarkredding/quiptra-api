class Listing < ApplicationRecord
	has_many :bookings
	has_many :users, through: :bookings, foreign_key: :renter_id
	belongs_to :owner, class_name: "User"
	validates_presence_of :owner_id, :price, :title, :body, :email, :phone, :street_address, :city, :state, :image_url

	def overlaps_booking_dates?(date_range)
		self.bookings.where(status: "approved").each do |booking|
			if booking.dates.overlaps?(date_range)
				return true
			end
		end
		return false
	end


	def booked_dates
		dates = []
		dateranges = self.bookings.where(status:"approved").map{|b| b.dates}
		dateranges.each do |dr|
			dr.each {|d| dates << d}
		end
		dates
	end


	# def self.filteredListings(s)

	# 	listings = []

	# 	case s
	# 	when -> (s) { s[:city] != "" && s[:state] != "" && s[:term] != "" }
	# 		listings = Listing.where("city LIKE '?%'", s[:city]).where("state LIKE '?%'", s[:state]).where("title LIKE '%?%'", s[:term])
	# 	when -> (s) { s[:city] != "" && s[:state] != "" }
	# 		listings = Listing.where("city LIKE '?%'", s[:city]).where("state LIKE '?%'", s[:state])
	# 	when -> (s) { s[:term] != "" && s[:state] != "" }
	# 		listings = Listing.where("state LIKE '?%'", s[:state]).where("title LIKE '%?%'", s[:term])
	# 	when -> (s) { s[:term] != "" && s[:city] != "" }
	# 		listings = Listing.where("city LIKE '?%'", s[:city]).where("title LIKE '%?%'", s[:term])
	# 	when -> (s) { s[:city] != "" }
	# 		listings = Listing.where("city LIKE '?%'", s[:city])
	# 	when -> (s) { s[:state] != "" }
	# 		listings = Listing.where("state LIKE '?%'", s[:state])
	# 	when -> (s) { s[:term] != "" }
	# 		listings = Listing.where("title LIKE '%?%'", s[:term])
	# 	end

	# 	if listings.empty?
	# 		listings = Listing.all
	# 	end

	# 	listings
	# end
end
