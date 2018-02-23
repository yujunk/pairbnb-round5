class SessionsController < Clearance::SessionsController
def create_from_omniauth
  auth_hash = request.env["omniauth.auth"]
  authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

  # if: previously already logged in with OAuth
  if authentication.user
    user = authentication.user
    authentication.update_token(auth_hash)
    @next = "/"
    @notice = "Signed in!"
  # else: user logs in with OAuth for the first time
  else
    user = User.create_with_auth_and_hash(authentication, auth_hash)
    # you are expected to have a path that leads to a page for editing user details
    @next = edit_user_path(user) 
      #it's a method that brings back a URL. "edit_user" is a prefix, but it is rooted from the controller user
      #edit_user is the prefix, _path is always going to be _path because it is rail's method of knowing that it is a route
      #redirect_to products_path = redirect_to "/products"
    @notice = "User created. Please confirm or edit details"
  end
  #^above is OmniAuth method

  sign_in(user) #this is a Clearance method - that picks up on OmniAuth user
  redirect_to @next, :notice => @notice
end
end 


