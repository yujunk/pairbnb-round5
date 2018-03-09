class Listing < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  include PgSearch

  has_many :reservations

  scope :location, -> (location) { where location: location }
  scope :price_per_night, -> (price_per_night) { where price_per_night: price_per_night }
  scope :smoking, -> (smoking) { where smoking: smoking }

  delegate :user_name, :to => :user, :prefix => true

  def self.search_location(query)
    where("location ILIKE :location", location: "%#{query}%").map do |record|
      record.location 
    end
  end

  def self.find_listings(parameters)
    
    listings = Listing.where(nil)
    
    parameters.each do |key, value|
      listings = listings.public_send(key, value) if value.present?
    end
    listings
    
  end


  

end
