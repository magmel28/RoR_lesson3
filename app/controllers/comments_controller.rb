class CommentsController < ApplicationController
  before_action :check_comment_permission, only: :destroy
  before_action :set_comment, only: [:update, :destroy]

  def index
  end

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = session[:user_id]
    @comment.save
    current_user.update_attribute('raiting', current_user.raiting *= 2)

    if @comment.save
      flash[:notice] = 'Your comment was sent'
      redirect_to @post
      @comment.post.touch
    else
      flash.now[:danger] = 'error'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    current_user.update_attribute('raiting', current_user.raiting /= 2)
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'The comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def check_comment_permission
    @comment = Comment.find(params[:id])
    unless @comment.user.id == session[:user_id]
      flash[:alert] = 'You have not permission!'
      redirect_to @comment.post
    end
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
