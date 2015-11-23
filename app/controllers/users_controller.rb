class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @user_posts = Post.where(user_id: @user.id)
    @user_favorites = @user.favorite_posts
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Green App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def index
    @users = User.all.order(:raiting).reverse
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
