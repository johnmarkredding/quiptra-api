class AddColumnStatusToBookings < ActiveRecord::Migration[5.2]
	def up
		execute <<-SQL
			CREATE TYPE booking_statuses AS ENUM ('pending', 'approved', 'denied');
			ALTER TABLE bookings ADD status booking_statuses DEFAULT 'pending';
		SQL
	end

	def down
		execute <<-SQL
			DROP TYPE booking_statuses;
		SQL
		remove_column :bookings, :status
	end
end
