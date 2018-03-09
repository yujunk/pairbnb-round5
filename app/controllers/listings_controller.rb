class ListingsController < ApplicationController

	def new
		@listing = Listing.new
	end

	def create
		@listing = Listing.new(listing_params)

		@listing.save
		
		redirect_to "/", notice: "Listing saved!"
	end

	def index	
    parameters = filtering_params(params)
    @listings = Listing.find_listings(parameters)
    
    @listings = @listings.order(id: :desc).page params[:page]
	end

	def edit
		allowed?(action: @listing, user: current_user)
		@listing = Listing.find(params[:id])
	end

	def update
		@listing = Listing.find(params[:id])
		@listing.update(update_listing_params)

		redirect_to listings_path
	end

	def search
    cities = Listing.search_location(params["query"])
    render json: cities 
  end

private

	def listing_params
		params.require(:listing).permit(:title, :description, :price_per_night, :smoking, :location, :user_id, :image, amenities: [])
	
	end

	def update_listing_params
		params.require(:listing).permit(:title, :description, :price_per_night, :smoking, :location)
	end

	def filtering_params(params)
    params.slice(:location, :smoking, :price_per_night)
  end

end






