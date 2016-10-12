class ReviewMailer < ApplicationMailer
  include SendGrid
  def new_review(review)
    @review = review

    mail(
      to: review.recipe.user.email,
      subject: "New Review for #{review.recipe.title}"
    )

  end
end
