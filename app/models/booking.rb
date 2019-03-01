class Booking < ApplicationRecord
	belongs_to :listing
	belongs_to :renter, class_name: "User"

	enum status: {
    pending: "pending",
    accepted: "accepted",
    denied: "denied"
  }
end
