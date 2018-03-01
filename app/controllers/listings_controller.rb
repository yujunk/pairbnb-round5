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
		#UserMailer.welcome_email(current_user).deliver_later(wait: 5.minutes) 

		@listings = Listing.where(nil)
  	filtering_params(params).each do |key, value|
    	@listings = @listings.public_send(key, value) if value.present?
    	#_send makes key your method, and value argument
  	end
  	
  	@listings = @listings.order(id: :desc).page params[:page]
  	
  	
  	#various methods deleted - refer to github

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

  def filter
  	@listings = Listing.where(nil)
  	@listings = Listing.where(location: params["query"])
  	@listings = @listings.where("location ILIKE :location", location: "%#{params['query']}%") 

  	@listings = @listings.map do |l|
  												#location col - like - symbol, symbol referring to what comes after comma - 'query' or :query both works
    	l.location
    end
    
  # 	filtering_params(params).each do |key, value|
  #   	@listings = @listings.public_send(key, value) if value.present?
  #   end
  #   @listings = @listings.map do |l|
  #   	l.location
		# end


  	render json: @listings 
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
  	params.slice(:location, :smoking, :price_per_night)
  	#no need for strong params (ie permit) because you are getting data, not inserting it into database
	end

end






