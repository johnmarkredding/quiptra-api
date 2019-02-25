User.destroy_all
Booking.destroy_all
Listing.destroy_all

jm = User.create(name: "John Mark", username: "johnmark", password: "none")
stv = User.create(name: "Stephen", username: "stephen", password: "none")

list1 = Listing.create(owner_id: jm.id)

book1 = Booking.create(renter_id: stv.id, listing_id: list1.id)