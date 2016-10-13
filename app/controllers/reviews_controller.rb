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
      else
        flash[:notice] = @review.errors.full_messages.join(', ')
      end
      redirect_to @recipe
    else
      sign_in
    end
  end

  def edit
    @review = Review.find(params[:id])
    if current_user != @review.user
      flash[:notice] = 'You cannot edit this review'
      redirect_to @review.recipe
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.user == current_user
      if @review.update_attributes(review_params)
        flash[:notice] = 'Review successfully edited'
        redirect_to @review.recipe
      else
        flash[:notice] = @review.errors.full_messages.join(', ')
        render 'edit'
      end
    else
      sign_in
    end
  end

  def destroy
    review = Review.find(params[:id])
    recipe = review.recipe
    if review.user == current_user || current_user.admin
      review.destroy
      flash[:notice] = 'Review successfully deleted'
      redirect_to recipe
    else
      sign_in
    end
  end

  def upvote
    @review = Review.find(params[:id])
    @recipe = @review.recipe
    @vote = Vote.find_or_create_by(user: current_user, review_id: @review.id)

    if user_signed_in?
      @vote.value != 1 ? @vote.update(value: 1) : @vote.update(value: 0)
      redirect_to recipe_path(@recipe)
    else
      sign_in
    end
  end

  def downvote
    @review = Review.find(params[:id])
    @vote = Vote.find_or_initialize_by(user: current_user, review_id: @review.id)
    @recipe = @review.recipe

    if user_signed_in?
      @vote.value != -1 ? @vote.update(value: -1) : @vote.update(value: 0)
      redirect_to recipe_path(@recipe)
    else
      sign_in
    end
  end

  def sign_in
    flash[:notice] = "Please sign in"
    redirect_to new_user_session_path
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end

end
