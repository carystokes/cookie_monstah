class VotesController < ApplicationController

  def update
    @vote = Vote.find(params[:id])
    binding.pry

    if user_signed_in?
      if params[:type] == 'up'
        @vote.value == 0 ? @vote.value = 1 : @vote.value = 0
      elsif params[:type] == 'down'
        @vote.value == 0 ? @vote.value = -1 : @vote.value = 0
      end
    else
      flash[:notice] = "Please sign in"
      redirect_to new_user_session_path
    end
  end
end
