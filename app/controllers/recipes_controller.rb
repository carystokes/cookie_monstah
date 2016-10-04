class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      flash[:notice] = "Recipe added successfully"
      redirect_to @recipe
    else
      flash[:notice] = @recipe.errors.full_messages.join(', ')
      render action: 'new'
    end
  end

  def edit
  end

  def destroy
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :ingredients, :instructions, :description)
  end
end
