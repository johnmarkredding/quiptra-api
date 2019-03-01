class BookingBlueprint < Blueprinter::Base
	identifier :id
	fields :renter_id, :listing_id, :dates, :id, :status
end