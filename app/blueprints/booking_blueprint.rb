class BookingBlueprint < Blueprinter::Base
	identifier :id
	fields :renter_id, :listing_id, :dates, :id, :status

	field :title do |booking|
		"#{booking.listing.title}"
	end
	field :listing_id do |booking|
		booking.listing.id
	end
end