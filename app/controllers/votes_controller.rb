class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.user = current_user
    @vote.review = Review.find(params[:id])
    @recipe = @review.recipe

    if @vote.save
      flash[:notice] = "Vote added successfully"
      redirect_to @recipe
    else
      flash[:notice] = @recipe.errors.full_messages.join(', ')
      redirect_to @recipe
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:user_id, :review_id, :value)
  end
end
