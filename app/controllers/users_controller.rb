class UsersController < Clearance::UsersController


	def create
		@user = User.new(user_params)
		@user.save

		redirect_to "/sign_in"
	end

  def user_listing
    @user_listings = current_user.listings
  end

	private 

	def user_params
		params.require(:user).permit(:email, :password, :name, :gender, :remember_token)
	end


end


