class ListingsController < ApplicationController

	def new
		@listing = Listing.new
		#creating a listing object, temporarily - so that the @form in the html file can actually display
		#give me a husk, but not saving into database 

		# render "listings/new" - Dont need to tell where rails to go since it knows by default 
	end

	def create
		@listing = Listing.new(listing_params)
		#@listing.user_id = current_user.id
		## ^Method 1 for saving user id to listing - https://stackoverflow.com/questions/8472370/how-to-pass-devises-current-user-as-user-id
		@listing.save
		#and then try .new & .save if create doesnt work
		redirect_to "/", notice: "Listing saved!"
	end

	def index
		if params[:search]
			@listings = Listing.where(location: params[:search])
		else
			@listings = Listing.all
		end

		@listings = Listing.order(price_per_night: :desc).page params[:page]

		#http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-order
		#https://github.com/amatsuda/kaminari
	end

	## Before refactoring:
	# def edit
	# 	# authorization code
 #      if current_user.customer?
 #        flash[:notice] = "Sorry. You are not allowed to perform this action."
 #        return redirect_to listings_path, notice: "Sorry. You do not have the permission to verify a property."
 #      else
 #      	@listing = Listing.find(params[:id])
 #      	#find_by, find, where etc - looks through database AND returns an object (with all the attributes). So this object can be passed into @listing
 #      end
 #      # end authorization code
	# end

	## After refactoring - moved to Application controller:
	def edit
		allowed?(action: @listing, user: current_user)
		@listing = Listing.find(params[:id])
	end

	def update
		@listing = Listing.find(params[:id])
		@listing.update(update_listing_params)

		redirect_to listings_path
	end

	private

	def listing_params
		#params.require(:listing).permit(:title, :description, :price_per_night, :smoking, :location)
		## ^Method 1
		byebug
		params.require(:listing).permit(:title, :description, :price_per_night, :smoking, :location, :user_id, amenities: [])
		## ^Method 2, just add :current_user.id into permitted params

		#Note 1: .save initiates created_at and updated_at. Handled by Rails.
		#Note 2: listing_params is a Rails feature, not Clearance.
	end

	def update_listing_params
		params.require(:listing).permit(:title, :description, :price_per_night, :smoking, :location)
	end

end






