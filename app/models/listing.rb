class Listing < ApplicationRecord
	has_many :bookings
	has_many :users, through: :bookings, foreign_key: :renter_id
	belongs_to :owner, class_name: "User"
end
