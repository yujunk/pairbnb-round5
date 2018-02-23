#RAILS_ENV=development load './CRUD/create_new_listings.rb'
#https://stackoverflow.com/questions/10313181/pass-ruby-script-file-to-rails-console

count = 0

while count < 30 do

	title = (0..10).map { ('a'..'z').to_a[rand(26)]}.join #did not randomize title, description, price, smoking
	description = (0..30).map { ('a'..'z').to_a[rand(26)]}.join
	price = (0..2).map { ('0'..'9').to_a[rand(rand(9))]}.join
	smoking = rand(2)
	location = ["Timbuktu", "Kuala Lumpur", "Istanbul", "Cape Town", "Havana"]

	listing = Listing.new(title: title, description: description, price_per_night: price, smoking: smoking, location: location[rand(5)], user_id: rand(1..4)) 
	listing.save
	count += 1
end