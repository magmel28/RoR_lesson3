class CommentsController < ApplicationController

  def index
    #@comments = @post.comments
  end

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = session[:user_id]
    @comment.save

    if @comment.save
      flash[:notice] = 'Your comment was sent'
      redirect_to @post
    else
      flash.now[:danger] = 'error'
    end
  end

  def destroy
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
