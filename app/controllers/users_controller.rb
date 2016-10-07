class UsersController < ApplicationController
  helper AvatarDefaultHelper

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
    if User.find(params[:id]) != current_user
      flash[:notice] = 'You may only edit your own profile.'
      @recipes = @user.recipes
      render 'show'
    end
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
    if User.find(params[:id]) == current_user || current_user.admin
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :avatar)
  end
end
