class UsersController < Clearance::UsersController

<<<<<<< HEAD
=======
  def new
    @user = User.new
  end

	def create
		@user = User.create(user_params)
		UserMailer.welcome_email(@user).deliver_now #delegating to slaveworker (sidekiq), otherwise it willl take forever for the page to render as it is trying to send the email.
    #redis is temporary storage for your worker to know what to do next

    # respond_to do 
      
        #Tell the UserMailer to send a welcome email after save, and deliver now
      
    #     redirect_to "/sign_in", notice: 'User was successfully created.'
    #   else
    #     redirect_to "/sign_in", notice: 'User was not created.'
    #   end
    # end

		redirect_to "/sign_in"
	end

>>>>>>> feature/email
  def user_listing
    @user_listings = current_user.listings
  end

	private 

	def user_params
		params.require(:user).permit(:email, :password, :name, :gender, :remember_token)
	end


end


