class UserMailer < ApplicationMailer
  default from: 'juntest0915@gmail.com' #change to address, but use Figaro
  #to: Proc.new { Admin.pluc(:email)}, #sending email to admin - not sure if it works?
 
  def welcome_email(user) 
    @user = user
    @url  = 'http://google.com' 
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')

    ##For full name:
    #email_with_name = %("#{@user.name}" <#{@user.email}>)
    #mail(to: email_with_name, subject: 'Welcome to My Awesome Site')
  end

end
