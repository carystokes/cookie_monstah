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
      @recipes = Recipe.all
    end
  end


  def show
    id = params[:id]
    @recipe = Recipe.find(id)
    @reviews = @recipe.reviews
    @review = Review.new
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
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update_attributes(recipe_params)
      flash[:notice] = "Recipe edited successfully"
      redirect_to @recipe
    else
      flash[:notice] = @recipe.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = "Recipe deleted"
    redirect_to root_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :ingredients, :instructions, :description)
  end
end
