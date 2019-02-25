class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
    	t.belongs_to :renter
      t.belongs_to :listing
      t.daterange :dates
      t.timestamps
    end
  end
end
