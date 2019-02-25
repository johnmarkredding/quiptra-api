class ListingBlueprint < Blueprinter::Base
	identifier :id
	fields :owner_id, :title, :body, :price, :email, :phone, :street_address, :city, :state, :image_url
end