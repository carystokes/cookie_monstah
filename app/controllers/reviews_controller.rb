class ReviewsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @review = Review.new(review_params)
    @review.recipe = @recipe
    @review.user = current_user

    if user_signed_in?
      if @review.save
        flash[:notice] = "Review created successfully"
        redirect_to recipe_path(@recipe)
      else
        flash[:notice] = @review.errors.full_messages.join(", ")
        redirect_to recipe_path(@recipe)
      end
    else
      flash[:notice] = "Please sign in"
      redirect_to new_user_session_path
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end

end
