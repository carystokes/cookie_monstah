# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name: ENV['SENDGRID_USERNAME'],
  password: ENV['SENDGRID_PASSWORD'],
  domain: 'cookie-monstah-recipes.herokuapp.com',
  address: 'smtp.sendgrid.new_user_session_path',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
