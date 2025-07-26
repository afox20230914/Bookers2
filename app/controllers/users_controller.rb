class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book_new = Book.new
    @post_images = @user.post_images
  end

  def index
    @users = User.order(created_at: :desc)
    @book_new = Book.new
  end

  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path
    end
  end

  def update
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user)
      return
    end
  
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  before_action :ensure_correct_user, only: [:edit, :update]

def ensure_correct_user
  user = User.find(params[:id])
  unless user == current_user
    redirect_to user_path(current_user)
  end
end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
