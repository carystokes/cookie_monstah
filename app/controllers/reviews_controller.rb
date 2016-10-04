class ReviewsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @review = Review.new(review_params)
    @review.recipe = @recipe

    if @review.save
      flash[:notice] = "Review created successfully"
      redirect_to recipe_path(@recipe)
    else
      flash[:notice] = @review.errors.full_messages.join(", ")
      redirect_to recipe_path(@recipe)
    end
  end

  private
  
  def review_params
    params.require(:review).permit(:rating, :body)
  end

end
