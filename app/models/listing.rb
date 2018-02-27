class Listing < ApplicationRecord
	belongs_to :user
	mount_uploader :image, ImageUploader

  has_many :reservations

  scope :location, -> (location) { where location: location }
  # SAME AS:
  # def location(location)
  #   where(location: location)
  # end
  scope :user, -> (user) { where user: user }
  scope :price_per_night, -> (price_per_night) { where price_per_night: price_per_night }
  scope :smoking, -> (smoking) { where smoking: smoking }
end

