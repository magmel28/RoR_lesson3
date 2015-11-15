class LikesController < ApplicationController

  def like
    @post = Post.find(params[:post_id])

    @like_presence = Like.where(post_id: @post.id, user_id: current_user.id).exists?
    unless @like_presence
      Like.create(post_id: @post.id, user_id: current_user.id)
    end

    @likes = @post.likes.all
  end

  def dislike
    @post = Post.find(params[:post_id])


  end



end
