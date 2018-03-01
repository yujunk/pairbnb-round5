class Listing < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  include PgSearch

  has_many :reservations

  scope :location, -> (location) { where location: location }
  scope :price_per_night, -> (price_per_night) { where price_per_night: price_per_night }
  scope :smoking, -> (smoking) { where smoking: smoking }

  def self.search_location(query)
    where("location ILIKE :location", location: "%#{query}%").map do |record|
      record.location 
    end
  end

end

#various methods deleted - refer to github