Rails.application.config.middleware.use OmniAuth::Builder do
 provider :facebook, ENV['FACEBOOK_APP_KEY'], ENV['FACEBOOK_APP_SECRET'],
 scope: 'email,public_profile', info_fields: 'email,first_name, gender'
end


#https://github.com/mkdynamic/omniauth-facebook#auth-hash
#https://developers.facebook.com/docs/graph-api/reference/user/