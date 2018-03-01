class Listing < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  include PgSearch

  pg_search_scope :search_by_title, :against => :title

  #DON'T USE:
  # pg_search_scope :search_by, lambda do |column, query|
  #   raise ArgumentError unless [:title, :location, :price_per_night].include?(column)
  #   {
  #     :against => column,
  #     :query => query
  #   }
  # end

  pg_search_scope :search_by, -> (column, query){
    raise ArgumentError unless [:title, :location, :price_per_night].include?(column)
    {
      :against => column,
      :query => query
    }
  }

  has_many :reservations

  scope :location, -> (location) { where location: location }
  # SAME AS:
  # def location(location)
  #   where(location: location)
  # end
  scope :user, -> (user) { where user: user }
  scope :price_per_night, -> (price_per_night) { where price_per_night: price_per_night }
  scope :smoking, -> (smoking) { where smoking: smoking }

  def self.search_location(query)
    where("location ILIKE :location", location: "%#{query}%").map do |record|
      record.location 
    end
  end

end

