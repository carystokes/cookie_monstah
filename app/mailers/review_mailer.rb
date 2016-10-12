require 'sendgrid-ruby'
include SendGrid

class ReviewMailer < ApplicationMailer
  def new_review(review)
    @review = review

    mail(
      to: review.recipe.user.email,
      subject: "New Review for #{review.recipe.title}"
    )

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end
end
