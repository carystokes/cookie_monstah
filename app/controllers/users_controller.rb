class UsersController < ApplicationController
  def index
    if current_user.admin
      @users = User.all
    else
      flash[:notice] = 'You are not authorized to view this page.'
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:notice] = 'User edited successfully'
      redirect_to @user
    else
      flash[:notice] = @user.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_path
  end
end
