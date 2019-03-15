class ListingBlueprint < Blueprinter::Base
	identifier :id
	fields :id, :owner_id, :title, :body, :price, :email, :phone, :street_address, :city, :state, :image_url

	association :bookings, blueprint: BookingBlueprint
end
