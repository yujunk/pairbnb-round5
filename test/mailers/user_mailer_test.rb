require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  # test "invite" do 
  #   # Send the email, then test that it got queued
  #   email = UserMailer.create_invite('juntest15@gmail.com', 'juntest15@gmail.com') Time.now).deliver_now
  #   assert_not ActionMailer::Base.deliveries.empty?
 
  #   # Test the body of the sent email contains what we expect it to
  #   assert_equal ['juntest15@gmail.com'], email.from
  #   assert_equal ['juntest15@gmail.com'], email.to
  #   assert_equal 'You have been invited by me@example.com', email.subject
  #   assert_equal read_fixture('invite').join, email.body.to_s
  # end
end
