class ListingsController < ApplicationController

	def new
		@listing = Listing.new
		# @uploader = ImageUploader.new #didint do anything

		#creating a listing object, temporarily - so that the @form in the html file can actually display
		#give me a husk, but not saving into database 

		# render "listings/new" - Dont need to tell where rails to go since it knows by default 
	end

	def create
		@listing = Listing.new(listing_params)
		# @uploader = ImageUploader.new(params[:image]) #didint do anything

		@listing.save
		#@listing.user_id = current_user.id
		## ^Method 1 for saving user id to listing - https://stackoverflow.com/questions/8472370/how-to-pass-devises-current-user-as-user-id
		#and then try .new & .save if create doesnt work
		redirect_to "/", notice: "Listing saved!"
	end

	def index
		#UserMailer.welcome_email(current_user).deliver_now #Directly with Action Mailer - just .deliver_now
		UserMailer.welcome_email(current_user).deliver_later(wait: 5.minutes) #Action Mailer > deliver_later > Sidekiq/Redis

		#UserJob.perform_later(current_user) #Action Mailer in Active Jobs - not completely correct...

		#METHOD 1: FORM TAG IMPLEMENTATION (PARAMS & BASIC)
		if params[:search]
			@listings = Listing.where(location: params[:search])
		else
			@listings = Listing.all
		end

		@listings = Listing.order(id: :desc).page params[:page]

		#http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-order
		#https://github.com/amatsuda/kaminari

		#METHOD 2: FORM TAG IMPLEMENTATION (USING SCOPES)
		@listings = Listing.where(nil)
  	filtering_params(params).each do |key, value|
  		# params = { controller: "listings", action: "serach", location: "Maysia"  }
  		# slice - > {location: "Malaysia", price_per_night: 100 , smoking: "", user: ""}

  		# @listings.location("Malaysia") - public_send - key = method, value = argument
  		# @listings.price_per_night(100)
    	@listings = @listings.public_send(key, value) if value.present?
  		
  	end

  	#METHOD 3: PGSEARCH GEM - STATIC
  	@listings = Listing.search_by_title(params[:title])

  	#METHOD 4: PGSEARCH GEM - DYNAMIC
  	@listings = Listing.search_by(:location, params[:search_by])
		
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

	def search
    cities = Listing.search_location(params["query"])
    render json: cities 
    #for renderring the results from the params
  end

private

	def listing_params
		#params.require(:listing).permit(:title, :description, :price_per_night, :smoking, :location)
		## ^Method 1
		params.require(:listing).permit(:title, :description, :price_per_night, :smoking, :location, :user_id, :image, amenities: [])
		## ^Method 2, just add :current_user.id into permitted params

		#Note 1: .save initiates created_at and updated_at. Handled by Rails.
		#Note 2: listing_params is a Rails feature, not Clearance.
	end

	def update_listing_params
		params.require(:listing).permit(:title, :description, :price_per_night, :smoking, :location)
	end

	def filtering_params(params)
  	params.slice(:location, :user, :smoking, :price_per_night)
	end

end






