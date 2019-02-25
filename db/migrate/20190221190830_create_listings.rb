class CreateListings < ActiveRecord::Migration[5.2]
	def change
		create_table :listings do |t|
			t.belongs_to :owner
			t.string :title
			t.string :body
			t.string :price
			t.string :email
			t.string :phone
			t.string :street_address
			t.string :city
			t.string :state
			t.string :image_url
			t.timestamps
		end
	end
end
