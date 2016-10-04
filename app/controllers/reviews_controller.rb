class ReviewsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @review = Review.new(review_params)
    @review.recipe = @recipe
    @review.save
    flash[:notice] = "Review created successfully"
    redirect_to recipe_path(@recipe)
  end

  private
  def review_params
    params.require(:review).permit(:rating, :body)
  end

end
