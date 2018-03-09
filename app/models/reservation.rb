class Reservation < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  delegate :title, :location, :price_per_night, :listing_user_name, :to => :listing, :prefix => true
end

