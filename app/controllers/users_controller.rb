class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images    
  end
  
  def edit
    @user = User.find(params[:id])
    redirect_to post_images_path unless @user == current_user
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user
      @user.update(user_params)
      redirect_to user_path(@user)
    else
      redirect_to post_images_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
