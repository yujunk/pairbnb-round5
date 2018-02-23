Clearance.configure do |config|
  config.routes = false
  config.allow_sign_up = true
  config.mailer_sender = "reply@example.com"
  config.rotate_csrf_on_sign_in = true
  config.password_strategy = Clearance::PasswordStrategies::BCrypt
  config.redirect_url = "/"
  config.sign_in_guards = []
  config.user_model = User
end
