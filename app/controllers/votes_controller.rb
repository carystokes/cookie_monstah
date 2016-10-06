class VotesController < ApplicationController

  def upvote
    @review = Review.find(params[:id])
    @vote = Vote.find_or_initialize_by(user: current_user)

    if user_signed_in?
      @vote.value == 0 ? @vote.value = 1 : @vote.value = 0
    else
      flash[:notice] = "Please sign in"
      redirect_to new_user_session_path
    end
  end

  def downvote
    @review = Review.find(params[:id])
    @vote = Vote.find_or_initialize_by(user: current_user)

    if user_signed_in?
      @vote.value == 0 ? @vote.value = -1 : @vote.value = 0
    else
      flash[:notice] = "Please sign in"
      redirect_to new_user_session_path
    end
  end
end
