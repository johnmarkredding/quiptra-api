require 'faker'

User.destroy_all
Booking.destroy_all
Listing.destroy_all

jm = User.create(name: "John Mark", username: "johnmark", password: "none")
stv = User.create(name: "Stephen", username: "stephen", password: "none")

list1 = nil
Faker::UniqueGenerator.clear
10.times do
	Listing.create(
		owner_id: jm.id,
		title: Faker::Vehicle.make_and_model,
		body: Faker::Lorem.paragraph(2),
		price: Faker::Number.within(1..10000),
		email: Faker::Internet.email,
		phone: Faker::PhoneNumber.cell_phone,
		street_address: Faker::Address.street_address,
		city: Faker::Address.city,
		state: Faker::Address.state_abbr,
		image_url: Faker::LoremPixel.image
	)
end


list1 = Listing.all.last

book1 = Booking.create(renter_id: stv.id, listing_id: list1.id)