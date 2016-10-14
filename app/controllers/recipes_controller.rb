class RecipesController < ApplicationController
  def index
    if params[:search] == ''
      flash.now[:alert] = 'Please specify a search phrase.'
    end
    if params[:search].present?
      @recipes = Recipe.search(params[:search])
      if @recipes.empty?
        flash.now[:notice] = 'Sorry, there were no matches.'
      else
        flash.now[:notice] = 'Check out your search matches below!'
      end
    else
      @recipes = Recipe.all.order(created_at: :desc)
    end
    if user_signed_in?
      @current_user = current_user
    end
  end

  def show
    id = params[:id]
    @recipe = Recipe.find(id)
    @reviews = @recipe.reviews.order(created_at: :desc)
    @review = Review.new
    @user = @recipe.user
  end

  def new
    if user_signed_in?
      @recipe = Recipe.new
    else
      flash[:notice] = "Please sign in"
      redirect_to new_user_session_path
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      flash[:notice] = "Recipe added successfully"
      redirect_to @recipe
    else
      flash[:notice] = @recipe.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    if current_user != @recipe.user
      flash[:notice] = 'You cannot edit this recipe'
      redirect_to @recipe
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.user == current_user
      if @recipe.update_attributes(recipe_params)
        flash[:notice] = "Recipe edited successfully"
        redirect_to @recipe
      else
        flash[:notice] = @recipe.errors.full_messages.join(', ')
        render 'edit'
      end
    else
      flash[:notice] = 'You do not have permission to edit this recipe'
      redirect_to @recipe
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    if recipe.user == current_user || current_user.admin
      recipe.destroy
      flash[:success] = "Recipe deleted"
      redirect_to root_path
    else
      flash[:notice] = 'You do not have permission to delete this recipe'
      redirect_to @recipe
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :ingredients, :instructions,
                  :description, :avatar)
  end
end
