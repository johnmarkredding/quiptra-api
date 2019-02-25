User.destroy_all
Booking.destroy_all
Listing.destroy_all

jm = User.create(name: "John Mark", username: "johnmark", password: "none")
stv = User.create(name: "Stephen", username: "stephen", password: "none")

list1 = Listing.create(
	owner_id: jm.id,
	title: "Hello! Bro! yo!!f YO! Yo! yO!",
	body: "jfkkfls fklsfjf glkjj kdsflk fk kfkjfl lekejr lkfkls",
	price: "5000",
	email: "johnmarkredding#@gmail.com",
	phone: "360-209-2115",
	street_address: "7810 7th Ave",
	city: "Brooklyn",
	state: "NY",
	image_url: "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"
)

book1 = Booking.create(renter_id: stv.id, listing_id: list1.id)