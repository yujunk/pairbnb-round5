class Listing < ApplicationRecord
	belongs_to :user
	mount_uploader :image, ImageUploader

  has_many :reservations
end
