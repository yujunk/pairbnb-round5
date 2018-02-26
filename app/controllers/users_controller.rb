class UsersController < Clearance::UsersController

  def user_listing
    @user_listings = current_user.listings
  end

	private 

	def user_params
		params.require(:user).permit(:email, :password, :name, :gender, :remember_token)
	end


end


