require 'sendgrid-ruby'
require 'json'
include SendGrid

class ReviewMailer < ApplicationMailer
  def new_review(review)
    @review = review

    mail(
      to: review.recipe.user.email,
      subject: "New Review for #{review.recipe.title}"
    )
  end
end
