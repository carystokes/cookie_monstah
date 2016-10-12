class ApplicationMailer < ActionMailer::Base
  default from: "\"Cookie Monster's Recipes\" <no-reply@example.com>"
  layout 'mailer'
end
