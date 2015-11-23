class FavoritePostsController < ApplicationController
  before_action :set_post, only: [:create, :destroy]

  def create
    #@post = Post.find(2)
    if Favorite.create(favorited: @post, user: current_user)
      redirect_to @post, notice: 'Post has been favorited'
    else
      redirect_to @post, alert: 'Something went wrong...'
    end
  end

  def destroy
    Favorite.where(favorited_id: @post.id, user_id: current_user.id).destroy_all
    redirect_to @post, notice: 'Post is no longer in favorites'
  end

  def index
    @user = User.find(params[:user_id])
    @user_favorites = @user.favorite_posts
  end

  def show
    @user = User.find(params[:user_id])
    @user_favorites = @user.favorite_posts
  end

  private

  def set_post
    @post = Post.find(params[:post_id] || params[:id])
  end
end
