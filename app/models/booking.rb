class Booking < ApplicationRecord
	belongs_to :listing
	belongs_to :renter, class_name: "User"

	enum status: {
    pending: "pending",
    approved: "approved",
    denied: "denied"
  }
end
