class ReviewsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @review = Review.new(review_params)
    @review.recipe = @recipe
    @review.user = current_user

    if user_signed_in?
      if @review.save
        flash[:notice] = 'Review created successfully'
        ReviewMailer.new_review(@review).deliver_later
        redirect_to recipe_path(@recipe)
      else
        flash[:notice] = @review.errors.full_messages.join(', ')
        redirect_to recipe_path(@recipe)
      end
    else
      flash[:notice] = 'Please sign in'
      redirect_to new_user_session_path
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])

    if @review.update_attributes(review_params)
      flash[:notice] = 'Review successfully edited'
      redirect_to @review.recipe
    else
      flash[:notice] = @review.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  def destroy
    review = Review.find(params[:id])
    recipe = review.recipe
    review.destroy
    flash[:success] = 'Review successfully deleted'
    redirect_to recipe
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end

end
